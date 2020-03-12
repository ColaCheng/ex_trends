defmodule ExTrends.DailyTrends do
  @moduledoc """
  Google daily trends operation
  """

  @doc """
  To build daily trends operation

  Args:
    * `geo` - Location of interest.
    * `hl` - Preferred language (defaults to `en-US`. Ref: [language-codes](https://sites.google.com/site/tomihasa/google-language-codes))
    * `tz` - Timezone Offset from UTC in minutes (defaults to 0)

  ## Examples
    `ExTrends.DailyTrends.request("TW") |> ExTrends.run()`
  """
  @spec request(geo :: binary, hl :: binary, tz :: integer) ::
          ExTrends.Operation.DailyTrends.t()
  def request(geo, hl \\ "en-US", tz \\ 0) do
    %ExTrends.Operation.DailyTrends{
      params: [geo: geo, hl: hl, tz: tz, ns: 15]
    }
  end
end
