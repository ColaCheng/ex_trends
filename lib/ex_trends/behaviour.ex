defmodule ExTrends.Behaviour do
  @moduledoc """
  A behaviour definition for the core operations of ExTrends
  """

  @callback run(ExTrends.Operation.t()) :: {:ok, term} | {:error, term}
  # @callback run(ExTrends.Operation.t(), Keyword.t()) :: {:ok, term} | {:error, term}

  # @callback run!(ExTrends.Operation.t()) :: term | no_return
  # @callback run!(ExTrends.Operation.t(), Keyword.t()) :: term | no_return
end
