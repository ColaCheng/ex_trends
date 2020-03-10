defmodule ExTrends do
  @behaviour ExTrends.Behaviour

  @impl true
  def request(op) do
    ExTrends.Operation.perform(op)
  end
end
