defmodule ExTrends.Operation.InterestOverTime do
  defstruct http_method: :get,
            url: "https://trends.google.com",
            path: "/trends/api/widgetdata/multiline",
            params: [],
            parser: &ExTrends.Operation.InterestOverTime.parser/1

  @type t :: %__MODULE__{}

  def parser({:ok, %{status_code: 200, body: body}}) do
    try do
      <<_::binary-size(5), data::binary>> = body
      {:ok, :jiffy.decode(data, [:return_maps]) |> Map.get("default", %{})}
    catch
      type, error -> {:error, {type, error}}
    end
  end

  def parser({:ok, response}), do: {:error, response}
  def parser(error), do: error
end
