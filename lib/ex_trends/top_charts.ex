defmodule ExTrends.TopCharts do
  @moduledoc """
  Google top charts operation

  Request data from Google's Top Charts section.
  """

  @doc """
  To build top charts operation

  Args:
    * `date` - Time of interest(YYYY or YYYYMM). Example 201611 for November 2016 Top Chart data.
    * `geo` - Location of interest.
    * `hl` - Preferred language (defaults to `en-US`. Ref: [language-codes](https://sites.google.com/site/tomihasa/google-language-codes))
    * `tz` - Timezone Offset from UTC in minutes (defaults to 0)

  ## Examples
    ExTrends.TopCharts.request("2019")
  """
  @spec request(date :: binary | integer, geo :: binary, hl :: binary, tz :: integer) ::
          ExTrends.Operation.TopCharts.t()
  def request(date, geo \\ "GLOBAL", hl \\ "en-US", tz \\ 0) do
    %ExTrends.Operation.TopCharts{
      params: [date: date, hl: hl, tz: tz, geo: geo, isMobile: false]
    }
  end
end
