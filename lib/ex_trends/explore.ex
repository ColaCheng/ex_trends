defmodule ExTrends.Explore do
  @doc false
  @spec request(query :: map) :: ExTrends.Operation.Explore.t()
  def request(%{keywords: keywords, time: time, geo: geo, hl: hl, tz: tz, cat: cat, prop: prop}) do
    comparison_item = for k <- keywords, do: %{keyword: k, time: time, geo: geo}
    req = :jiffy.encode(%{comparisonItem: comparison_item, category: cat, property: prop})

    %ExTrends.Operation.Explore{
      params: [hl: hl, tz: tz, req: req]
    }
    |> struct()
  end
end
