defmodule ExTrends.Operation.Explore do
  defstruct http_method: :get,
            url: "https://trends.google.com",
            path: "/trends/api/explore",
            params: [],
            parser: &ExTrends.Operation.Explore.parser/1

  @type t :: %__MODULE__{}

  def parser({:ok, %{status_code: 200, body: body}}) do
    try do
      <<_::binary-size(4), data::binary>> = body

      result =
        :jiffy.decode(data, [:return_maps])
        |> Map.get("widgets")

      {:ok, result}
    catch
      type, error -> {:error, {type, error}}
    end
  end

  def parser({:ok, response}), do: {:error, response}
  def parser(error), do: error
end
