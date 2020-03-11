defmodule ExTrends.Behaviour do
  @moduledoc """
  A behaviour definition for the core operations of ExTrends
  """
  @type t :: %{
          http_method: :get,
          url: binary,
          path: binary,
          params: list,
          parser: ({:ok | :error, term} -> {:ok | :error, term})
        }

  @callback run(t()) :: {:ok, term} | {:error, term}
  @callback run!(t()) :: term | no_return
end
