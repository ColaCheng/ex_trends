defmodule ExTrends.MixProject do
  use Mix.Project

  def project do
    [
      app: :ex_trends,
      version: "0.1.0",
      elixir: "~> 1.9",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      application: [],
      extra_applications: [:logger],
      mod: {ExTrends.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:hackney, "~> 1.15"},
      {:jiffy, "~> 1.0"}
    ]
  end
end
