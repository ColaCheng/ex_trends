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

  @default_opts [recv_timeout: 30_000]

  def request(method, url, body \\ "", headers \\ [], http_opts \\ []) do
    opts = Application.get_env(:ex_trends, :hackney_opts, @default_opts)
    opts = http_opts ++ [:with_body | opts]

    case :hackney.request(method, url, headers, body, opts) do
      {:ok, status, headers} ->
        {:ok, %{status_code: status, headers: headers}}

      {:ok, status, headers, body} ->
        {:ok, %{status_code: status, headers: headers, body: body}}

      {:error, reason} ->
        {:error, %{reason: reason}}
    end
  end
end
