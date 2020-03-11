defmodule ExTrends.Operation.Categories do
  defstruct http_method: :get,
            url: "https://trends.google.com",
            path: "/trends/api/explore/pickers/category",
            params: [],
            parser: &ExTrends.Operation.Categories.parser/1

  @type t :: %__MODULE__{}

  def parser({:ok, %{status_code: 200, headers: _headers, body: body}}) do
    try do
      <<_::binary-size(5), data::binary>> = body
      {:ok, :jiffy.decode(data, [:return_maps])}
    catch
      _ -> {:error, :error1}
      _, _ -> {:error, :error2}
    end
  end

  def parser(error), do: error
end
