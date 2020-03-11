defmodule ExTrends.InterestOverTime do
  defstruct keyword: nil,
            time: "today 5-y",
            geo: "US",
            hl: "en-US",
            tz: "360",
            prop: "",
            cat: 0

  @id "TIMESERIES"

  @spec request(%{
          required(:keyword) => binary | list(binary),
          optional(:time) => binary,
          optional(:geo) => binary,
          optional(:hl) => binary,
          optional(:tz) => binary,
          optional(:prop) => binary,
          optional(:cat) => integer
        }) :: ExTrends.Operation.InterestOverTime.t()
  def request(%{keyword: keyword} = query) when is_binary(keyword) or is_list(keyword) do
    %{hl: hl, tz: tz} =
      explore_query =
      %ExTrends.InterestOverTime{}
      |> struct(query)
      |> Map.from_struct()
      |> Map.put(:keywords, (is_binary(keyword) && [keyword]) || keyword)

    with {:ok, explore} <- ExTrends.Explore.request(explore_query) |> ExTrends.run(),
         %{"request" => request, "token" => token} <-
           Enum.find(explore, &(Map.get(&1, "id") == @id)) do
      req = :jiffy.encode(request)

      %ExTrends.Operation.InterestOverTime{params: [hl: hl, tz: tz, req: req, token: token]}
      |> struct()
    else
      nil -> {:error, :notfound}
      _ -> {:error, :error}
    end
  end
end
