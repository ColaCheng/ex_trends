defmodule ExTrends.Operation.DailyTrends do
  defstruct http_method: :get,
            url: "https://trends.google.com/trends/api/dailytrends",
            # params: %{hl: "en-US", tz: "-480", ns: "15"},
            params: %{},
            parser: &ExTrends.Operation.DailyTrends.parser/1

  @type t :: %__MODULE__{}

  def parser({:ok, data}) do
    try do
      result =
        String.trim(data, ")]}',\n")
        |> :jiffy.decode([:return_maps])
        |> get_in(["default", "trendingSearchesDays"])
        |> hd()
        |> Map.get("trendingSearches")

      {:ok, result}
    catch
      _ ->
        {:error, :error}
    end
  end

  def parser(error), do: error
end

defimpl ExTrends.Operation, for: ExTrends.Operation.DailyTrends do
  def perform(operation) do
    ExTrends.Request.request(operation.http_method, operation.url, operation.params)
    |> operation.parser.()
  end
end
