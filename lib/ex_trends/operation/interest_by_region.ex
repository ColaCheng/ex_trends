defmodule ExTrends.Operation.InterestByRegion do
  defstruct http_method: :get,
            url: "https://trends.google.com",
            path: "/trends/api/widgetdata/comparedgeo",
            params: [],
            parser: &ExTrends.Operation.InterestByRegion.parser/1

  @type t :: %__MODULE__{}

  def parser({:ok, %{status_code: 200, headers: _headers, body: body}}) do
    try do
      <<_::binary-size(5), data::binary>> = body
      {:ok, :jiffy.decode(data, [:return_maps]) |> Map.get("default", %{})}
    catch
      _ -> {:error, :error1}
      _, _ -> {:error, :error2}
    end
  end

  def parser(error), do: error
end

defimpl ExTrends.Operation, for: ExTrends.Operation.InterestByRegion do
  def perform(operation) do
    url = :hackney_url.make_url(operation.url, operation.path, operation.params)

    cookie =
      case ExTrends.Cookie.get() do
        {:ok, cookie_v} -> cookie_v
        _ -> ""
      end

    ExTrends.Request.request(operation.http_method, url, "", [{"Cookie", cookie}], [])
    |> operation.parser.()
  end
end
