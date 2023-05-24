# SPDX-License-Identifier: ISC

defmodule TorDir.MixProject do
  use Mix.Project

  def project do
    [
      app: :tor_dir,
      version: "0.1.0",
      elixir: "~> 1.13",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      licenses: ["ISC"]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    []
  end
end
