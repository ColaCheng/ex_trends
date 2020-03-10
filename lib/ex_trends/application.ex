defmodule ExTrends.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      {ExTrends.Cookie, []}
    ]

    opts = [strategy: :one_for_one, name: ExTrends.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
