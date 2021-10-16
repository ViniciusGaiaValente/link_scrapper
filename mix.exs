defmodule LinkScraper.MixProject do
  use Mix.Project

  def project do
    [
      app: :link_scraper,
      version: "0.1.0",
      elixir: "~> 1.12",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:tesla, "~> 1.4"},
      {:hackney, "~> 1.17"},
      {:jason, ">= 1.0.0"},
      {:floki, "~> 0.31.0"},
      {:mock, "~> 0.3.0", only: :test}
    ]
  end
end
