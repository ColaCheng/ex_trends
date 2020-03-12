defmodule ExTrends.Operation.Categories do
  defstruct http_method: :get,
            url: "https://trends.google.com",
            path: "/trends/api/explore/pickers/category",
            params: [],
            parser: &ExTrends.Operation.Categories.parser/1

  @type t :: %__MODULE__{}

  @doc false
  def parser({:ok, %{status_code: 200, body: body}}) do
    try do
      <<_::binary-size(5), data::binary>> = body
      {:ok, :jiffy.decode(data, [:return_maps])}
    catch
      type, error -> {:error, {type, error}}
    end
  end

  def parser({:ok, response}), do: {:error, response}
  def parser(error), do: error
end
