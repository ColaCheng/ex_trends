defmodule ExTrends.Operation.TopCharts do
  defstruct http_method: :get,
            url: "https://trends.google.com/trends/api/topcharts",
            params: %{},
            parser: &ExTrends.Operation.TopCharts.parser/1

  @type t :: %__MODULE__{}

  def parser({:ok, data}) do
    try do
      <<_::binary-size(5), real_data::binary>> = data

      result =
        case :jiffy.decode(real_data, [:return_maps]) |> Map.get("topCharts") do
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
    ExTrends.Request.request(operation.http_method, operation.url, operation.params)
    |> operation.parser.()
  end
end
