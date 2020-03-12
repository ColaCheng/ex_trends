defmodule ExTrends do
  use Application
  @behaviour ExTrends.Behaviour

  @doc false
  @impl Application
  def start(_type, _args) do
    children = [
      {ExTrends.Cookie, []}
    ]

    opts = [strategy: :one_for_one, name: ExTrends.Supervisor]
    Supervisor.start_link(children, opts)
  end

  @doc """
  Run a Google Trends operation

  First build an operation from one of the operation, and then pass it to this
  function to run it.

  If you want to build an operation manually, see: `ExTrends.Operation`

  ## Examples
  You can just use those operation modules like this:
  ```
  ExTrends.DailyTrends.request("TW") |> ExTrends.run()
  ```
  """
  @impl ExTrends.Behaviour
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

  @doc """
  Run a Google Trends operation, raise if it fails.

  Same as `run/1,2` except it will either return the successful response from
  Google or raise an exception.
  """
  @impl ExTrends.Behaviour
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
