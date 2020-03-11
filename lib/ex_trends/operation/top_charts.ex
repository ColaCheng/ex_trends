defmodule ExTrends.Operation.TopCharts do
  defstruct http_method: :get,
            url: "https://trends.google.com",
            path: "/trends/api/topcharts",
            params: [],
            parser: &ExTrends.Operation.TopCharts.parser/1

  @type t :: %__MODULE__{}

  def parser({:ok, %{status_code: 200, body: body}}) do
    try do
      <<_::binary-size(5), data::binary>> = body

      result =
        case :jiffy.decode(data, [:return_maps]) |> Map.get("topCharts") do
          [h | _] -> Map.get(h, "listItems")
          [] -> []
        end

      {:ok, result}
    catch
      type, error -> {:error, {type, error}}
    end
  end

  def parser({:ok, response}), do: {:error, response}
  def parser(error), do: error
end
