defmodule ExTrends.Request do
  # python ref: https://github.com/GeneralMills/pytrends
  # @general_url "https://trends.google.com/trends/api/explore"
  # @interest_over_time_url "https://trends.google.com/trends/api/widgetdata/multiline"
  # @interest_by_region_url "https://trends.google.com/trends/api/widgetdata/comparedgeo"
  # @related_queries_url "https://trends.google.com/trends/api/widgetdata/relatedsearches"
  # @trending_searches_url "https://trends.google.com/trends/hottrends/visualize/internal/data"
  # @top_charts_url "https://trends.google.com/trends/api/topcharts"
  # @suggestions_url "https://trends.google.com/trends/api/autocomplete/"
  # @categories_url "https://trends.google.com/trends/api/explore/pickers/category"
  @daily_trends_url "https://trends.google.com/trends/api/dailytrends"

  def get_daily_trends(geo) do
    case do_request(:get, @daily_trends_url, %{hl: "en-US", tz: "-480", geo: geo, ns: "15"}) do
      {:ok, data} ->
        req_json =
          String.trim(data, ")]}',\n")
          |> :jiffy.decode([:return_maps])
          |> get_in(["default", "trendingSearchesDays"])
          |> hd()
          |> Map.get("trendingSearches")

        req_json

      error ->
        error
    end
  end

  defp do_request(method, url, params) do
    case HTTPoison.request(method, url, "", [], params: params) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} -> {:ok, body}
      {:ok, %HTTPoison.Response{status_code: status_code}} -> {:error, status_code}
      error -> error
    end
  end
end
