defmodule ExTrends.Cookie do
  use GenServer

  @ets_table :google_trends_cookie
  @cookie_url "https://trends.google.com"
  @interval 60 * 60 * 1_000

  def start_link(_) do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def get() do
    case :ets.lookup(@ets_table, :cookie) do
      [cookie: cookie] -> {:ok, cookie}
      [] -> {:error, :notfound}
    end
  end

  @impl true
  def init(_) do
    :ets.new(@ets_table, [:named_table, write_concurrency: true, read_concurrency: true])
    send(self(), :timeout)
    {:ok, []}
  end

  @impl true
  def handle_info(:timeout, state) do
    with {:ok, %{status_code: 200, headers: headers}} <-
           ExTrends.Request.request(:get, @cookie_url, "", [], follow_redirect: true),
         cookie when cookie != :undefined <- :proplists.get_value("Set-Cookie", headers) do
      [cookie_value | _] = String.split(cookie, ";")
      :ets.insert(@ets_table, {:cookie, cookie_value})
    else
      _ -> Process.send_after(self(), :timeout, 5000)
    end

    {:noreply, state, @interval}
  end
end
