defmodule ExTrends.InterestByRegion do
  defstruct keyword: nil,
            time: "today 5-y",
            geo: "US",
            # "COUNTRY" | "REGION" | "CITY" | "DMA"
            resolution: "DMA",
            hl: "en-US",
            tz: "360",
            prop: "",
            cat: 0

  @id "GEO_MAP"

  @spec request(%{
          required(:keyword) => binary | list(binary),
          optional(:time) => binary,
          optional(:geo) => binary,
          optional(:resolution) => binary,
          optional(:hl) => binary,
          optional(:tz) => binary,
          optional(:prop) => binary,
          optional(:cat) => integer
        }) :: ExTrends.Operation.InterestByRegion.t()
  def request(%{keyword: keyword} = query) when is_binary(keyword) or is_list(keyword) do
    %{hl: hl, tz: tz, resolution: resolution} =
      explore_query =
      %ExTrends.InterestByRegion{}
      |> struct(query)
      |> Map.from_struct()
      |> Map.put(:keywords, (is_binary(keyword) && [keyword]) || keyword)

    with {:ok, explore} <- ExTrends.Explore.request(explore_query) |> ExTrends.request(),
         %{"request" => request, "token" => token} <-
           Enum.find(explore, &(Map.get(&1, "id") == @id)) do
      req = :jiffy.encode(Map.put(request, "resolution", resolution))

      %ExTrends.Operation.InterestByRegion{params: [hl: hl, tz: tz, req: req, token: token]}
      |> struct()
    else
      nil -> {:error, :notfound}
      _ -> {:error, :error}
    end
  end
end