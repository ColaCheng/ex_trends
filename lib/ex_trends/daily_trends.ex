defmodule ExTrends.DailyTrends do
  @spec request(geo :: binary, hl :: binary, tz :: binary, ns :: binary) ::
          ExTrends.Operation.DailyTrends.t()
  def request(geo, hl \\ "en-US", tz \\ "-480", ns \\ "15") do
    %ExTrends.Operation.DailyTrends{
      params: %{geo: geo, hl: hl, tz: tz, ns: ns}
    }
    |> struct()
  end
end
