defmodule ExTrends.Categories do
  @spec request(hl :: binary) :: ExTrends.Operation.Categories.t()
  def request(hl \\ "en-US") do
    %ExTrends.Operation.Categories{params: [hl: hl]}
    |> struct()
  end
end
