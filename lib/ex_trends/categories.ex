defmodule ExTrends.Categories do
  @moduledoc """
  Google categories data operation
  """

  @doc """
  To build available categories data operation

  Args:
    * `hl` - Preferred language (defaults to `en-US`. Ref: [language-codes](https://sites.google.com/site/tomihasa/google-language-codes))

  ## Examples
    `ExTrends.Categories.request("zh-TW") |> ExTrends.run()`
  """
  @spec request(hl :: binary) :: ExTrends.Operation.Categories.t()
  def request(hl \\ "en-US") do
    %ExTrends.Operation.Categories{params: [hl: hl]}
  end
end
