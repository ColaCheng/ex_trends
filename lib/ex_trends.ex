defmodule ExTrends do
  @behaviour ExTrends.Behaviour

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
