defmodule ExTrends.Operation.DailyTrends do
  defstruct http_method: :get,
            url: "https://trends.google.com",
            path: "/trends/api/dailytrends",
            params: [],
            parser: &ExTrends.Operation.DailyTrends.parser/1

  @type t :: %__MODULE__{}

  @doc false
  def parser({:ok, %{status_code: 200, body: body}}) do
    try do
      <<_::binary-size(5), data::binary>> = body

      result =
        :jiffy.decode(data, [:return_maps])
        |> get_in(["default", "trendingSearchesDays"])
        |> hd()
        |> Map.get("trendingSearches")

      {:ok, result}
    catch
      type, error -> {:error, {type, error}}
    end
  end

  def parser({:ok, response}), do: {:error, response}
  def parser(error), do: error
end
