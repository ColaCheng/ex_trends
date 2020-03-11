defmodule ExTrends.Suggestions do
  defstruct keyword: nil,
            time: "today 5-y",
            geo: "US",
            hl: "en-US",
            tz: "360",
            prop: "",
            cat: 0

  @spec request(%{
          required(:keyword) => binary,
          optional(:time) => binary,
          optional(:geo) => binary,
          optional(:hl) => binary,
          optional(:tz) => binary,
          optional(:prop) => binary,
          optional(:cat) => integer
        }) :: ExTrends.Operation.Suggestions.t()
  def request(%{keyword: keyword} = query) do
    %{hl: hl, tz: tz} =
      explore_query =
      %ExTrends.Suggestions{}
      |> struct(query)
      |> Map.from_struct()
      |> Map.put(:keywords, [keyword])

    case ExTrends.Explore.request(explore_query) |> ExTrends.run() do
      {:ok, [%{"request" => request, "token" => token} | _]} ->
        %{path: path} = suggestions = %ExTrends.Operation.Suggestions{}
        req = :jiffy.encode(request)

        %ExTrends.Operation.Suggestions{
          suggestions
          | params: [hl: hl, tz: tz, req: req, token: token],
            path: path <> "/" <> URI.encode(keyword)
        }
        |> struct()

      _ ->
        {:error, :error}
    end
  end
end
