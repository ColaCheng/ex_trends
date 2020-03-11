defmodule ExTrends do
  use Application
  @behaviour ExTrends.Behaviour

  @impl true
  def start(_type, _args) do
    children = [
      {ExTrends.Cookie, []}
    ]

    opts = [strategy: :one_for_one, name: ExTrends.Supervisor]
    Supervisor.start_link(children, opts)
  end

  @impl true
  def run(operation) do
    url = :hackney_url.make_url(operation.url, operation.path, operation.params)

    cookie =
      case ExTrends.Cookie.get() do
        {:ok, cookie_v} -> cookie_v
        _ -> ""
      end

    ExTrends.Request.request(operation.http_method, url, "", [{"Cookie", cookie}], [])
    |> operation.parser.()
  end

  @impl true
  def run!(operation) do
    case run(operation) do
      {:ok, result} ->
        result

      error ->
        raise ExTrends.Error, """
        ExTrends Request Error!
        #{inspect(error)}
        """
    end
  end
end
