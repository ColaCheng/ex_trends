defmodule ExTrends.TopCharts do
  @spec request(date :: binary, geo :: binary, hl :: binary, tz :: binary) ::
          ExTrends.Operation.TopCharts.t()
  def request(date, geo \\ "GLOBAL", hl \\ "en-US", tz \\ "300") do
    %ExTrends.Operation.TopCharts{
      params: [date: date, hl: hl, tz: tz, geo: geo, isMobile: false]
    }
  end
end
