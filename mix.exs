defmodule HeliosExample.MixProject do
  use Mix.Project

  def project do
    [
      app: :helios_example,
      version: "0.1.0",
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :extreme, :helios],
      mod: {HeliosExample.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:helios, path: "../helios"},
      # {:helios, "~> 0.1"},
      {:extreme, "~> 0.13", override: true},
      {:libcluster, "~> 3.0"},
      {:benchee, "~> 0.11"}
    ]
  end
end
