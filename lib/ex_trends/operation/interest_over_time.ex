defmodule ExTrends.Operation.InterestOverTime do
  defstruct http_method: :get,
            url: "https://trends.google.com",
            path: "/trends/api/widgetdata/multiline",
            params: [],
            parser: &ExTrends.Operation.InterestOverTime.parser/1

  @type t :: %__MODULE__{}

  def parser({:ok, %{status_code: 200, headers: _headers, body: body}}) do
    try do
      <<_::binary-size(5), data::binary>> = body
      {:ok, :jiffy.decode(data, [:return_maps]) |> Map.get("default", %{})}
    catch
      _ -> {:error, :error1}
      _, _ -> {:error, :error2}
    end
  end

  def parser(error), do: error
end
