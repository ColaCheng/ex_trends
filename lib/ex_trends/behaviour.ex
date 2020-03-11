defmodule ExTrends.Behaviour do
  @moduledoc """
  A behaviour definition for the core operations of ExTrends
  """
  @type t :: %{
          http_method: :get | :post,
          url: binary,
          path: binary,
          params: list,
          parser: ({:ok | :error, map} -> {:ok | :error, map | atom})
        }

  @callback run(t()) :: {:ok, term} | {:error, term}
end
