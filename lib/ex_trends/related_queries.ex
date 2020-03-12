defmodule ExTrends.RelatedQueries do
  @moduledoc """
  Google related queries operation

  Users searching for your term also searched for these queries.
  """
  defstruct keyword: nil,
            time: "today 5-y",
            geo: "",
            hl: "en-US",
            tz: 0,
            prop: "",
            cat: 0

  @id "RELATED_QUERIES"

  @doc """
  To build related queries operation

  Map keys:
    * `keyword` - type string or list of string - the search term(s) of interest.
    * `time` - Location of interest.
    * `geo` - geocode for a country, region, or DMA depending on the granularity required (defaults to worldwide). For example, `geo: "US-CA-800"` will target the Bakersfield, California, United States or `geo: "US"` will just target the US.
    * `hl` - Preferred language (defaults to `en-US`. Ref: [language-codes](https://sites.google.com/site/tomihasa/google-language-codes))
    * `tz` - Timezone Offset from UTC in minutes. (defaults to 0)
    * `prop` - Google property to filter on. Defaults to web search. (enumerated string [`images`, `news`, `youtube` or `froogle`] where froogle is Google Shopping results)
    * `cat` - A number corresponding to a particular category to query within (defaults to all categories), see the [category wiki](https://github.com/pat310/google-trends-api/wiki/Google-Trends-Categories) for a complete list.

  ## Time format
  - Date to start from
  - Defaults to last 5yrs, `"today 5-y"`.
  - Everything `"all"`
  - Specific dates, "YYYY-MM-DD YYYY-MM-DD" example `"2016-12-14 2017-01-25"`
  - Specific datetimes, "YYYY-MM-DDTHH YYYY-MM-DDTHH" example `"2017-02-06T10 2017-02-12T07"`
      - Note Time component is based off UTC

  - Current Time Minus Time Pattern:

    - By Month: ```"today #-m"``` where # is the number of months from that date to pull data for
      - For example: ``"today 3-m"`` would get data from today to 3months ago
      - **NOTE** Google uses UTC date as *"today"*
      - Seems to only work for 1, 2, 3 months only

    - Daily: ```"now #-d"``` where # is the number of days from that date to pull data for
      - For example: ``"now 7-d"`` would get data from the last week
      - Seems to only work for 1, 7 days only

    - Hourly: ```"now #-H"``` where # is the number of hours from that date to pull data for
      - For example: ``"now 1-H"`` would get data from the last hour
      - Seems to only work for 1, 4 hours only

  ## Examples
    ExTrends.RelatedQueries.request(%{keyword: "virus"})
  """
  @spec request(%{
          required(:keyword) => binary | list(binary),
          optional(:time) => binary,
          optional(:geo) => binary,
          optional(:hl) => binary,
          optional(:tz) => binary,
          optional(:prop) => binary,
          optional(:cat) => integer
        }) :: ExTrends.Operation.RelatedQueries.t() | no_return
  def request(%{keyword: keyword} = query) when is_binary(keyword) do
    request(Map.put(query, :keyword, [keyword]))
  end

  def request(%{keyword: keywords} = query) do
    %{hl: hl, tz: tz} =
      explore_query =
      %ExTrends.RelatedQueries{}
      |> struct(query)
      |> Map.from_struct()
      |> Map.put(:keywords, keywords)

    with explore <- ExTrends.Explore.request(explore_query) |> ExTrends.run!(),
         %{"request" => request, "token" => token} <-
           Enum.find(explore, &(Map.get(&1, "id") == @id)) do
      req = :jiffy.encode(request)

      %ExTrends.Operation.RelatedQueries{params: [hl: hl, tz: tz, req: req, token: token]}
    else
      nil ->
        raise ExTrends.Error, """
        ExTrends Request Error!
        Can not build Operation
        """
    end
  end
end
