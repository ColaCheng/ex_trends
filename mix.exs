defmodule ExTrends.MixProject do
  use Mix.Project

  @description """
    Elixir Google Trends client
  """

  def project do
    [
      app: :ex_trends,
      version: "0.1.0",
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      description: @description,
      name: "ExTrends",
      source_url: "https://github.com/ColaCheng/ex_trends",
      package: package(),
      docs: docs(),
      dialyzer: [
        plt_add_deps: :transitive,
        flags: [
          :unmatched_returns,
          :race_conditions,
          :underspecs
          # :overspecs,
          # :specdiffs
        ]
      ]
    ]
  end

  def application do
    [
      application: [],
      extra_applications: [:logger],
      mod: {ExTrends, []}
    ]
  end

  defp deps do
    [
      {:hackney, "~> 1.15"},
      {:jiffy, "~> 1.0"},
      {:dialyxir, "~> 1.0.0-rc.7", only: [:dev], runtime: false}
    ]
  end

  def docs do
    [
      readme: "README.md",
      main: ExTrends
    ]
  end

  defp package do
    [
      maintainers: ["Cola Cheng"],
      licenses: ["MIT"],
      links: %{GitHub: "https://github.com/ColaCheng/ex_trends"}
    ]
  end
end
