defmodule ExTrends.Behaviour do
  @moduledoc """
  A behaviour definition for the core operations of ExTrends
  """

  @callback request(ExTrends.Operation.t()) :: {:ok, term} | {:error, term}
  @callback request(ExTrends.Operation.t(), Keyword.t()) :: {:ok, term} | {:error, term}

  @callback request!(ExTrends.Operation.t()) :: term | no_return
  @callback request!(ExTrends.Operation.t(), Keyword.t()) :: term | no_return
end
