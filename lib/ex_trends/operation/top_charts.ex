defmodule ExTrends.Operation.TopCharts do
  defstruct http_method: :get,
            url: "https://trends.google.com",
            path: "/trends/api/topcharts",
            params: [],
            parser: &ExTrends.Operation.TopCharts.parser/1

  @type t :: %__MODULE__{}

  def parser({:ok, %{status_code: _status, headers: _headers, body: body}}) do
    try do
      <<_::binary-size(5), data::binary>> = body

      result =
        case :jiffy.decode(data, [:return_maps]) |> Map.get("topCharts") do
          [h | _] -> Map.get(h, "listItems")
          [] -> []
        end

      {:ok, result}
    catch
      _ -> {:error, :error}
      _, _ -> {:error, :error}
    end
  end

  def parser(error), do: error
end

defimpl ExTrends.Operation, for: ExTrends.Operation.TopCharts do
  def perform(operation) do
    url = :hackney_url.make_url(operation.url, operation.path, operation.params)
    ExTrends.Request.request(operation.http_method, url)
    |> operation.parser.()
  end
end
