defmodule ExTrends do
  @behaviour ExTrends.Behaviour

  @impl true
  def run(op) do
    ExTrends.Operation.perform(op)
  end
end
