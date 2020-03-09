defmodule ExTrends.Operation.DailyTrends do
  defstruct http_method: :get,
            url: "https://trends.google.com/trends/api/dailytrends",
            params: %{}

  @type t :: %__MODULE__{}
end

defimpl ExTrends.Operation, for: ExTrends.Operation.DailyTrends do
  def perform(operation, config) do
  end
end
