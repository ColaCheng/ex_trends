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
  # @daily_trends_url "https://trends.google.com/trends/api/dailytrends"

  def request(method, url, params) do
    case HTTPoison.request(method, url, "", [], params: params) do
      {:ok, %HTTPoison.Response{status_code: status, body: body}}
      when status in 200..299 or status == 304 ->
        {:ok, body}

      {:ok, %HTTPoison.Response{status_code: 301}} ->
        {:error, 301}

      error ->
        error
    end
  end
end
