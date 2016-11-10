defmodule Bootform.Mixfile do
  use Mix.Project

  def project do
    [app: :bootform,
     version: "0.1.0",
     elixir: "~> 1.3",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     description: description(),
     package: package(),
     deps: deps()]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:logger]]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [
      {:phoenix_html, "~> 2.7"},
      {:phoenix, "~> 1.2"},
      {:ecto, "~> 2.0"}
    ]
  end

  defp description do
    """
    Create bootstrap 4 friendly forms with ease. Build on tope of Phoenix.Form
    """
  end

  defp package do
    [# These are the default files included in the package
     name: :bootform,
     maintainers: ["Jonathan Boyer"],
     licenses: ["Apache 2.0"],
     links: %{"GitHub" => "https://github.com/Grafikart/elixir-bootform",
              "Docs" => "https://hexdocs.pm/bootform/"}]
  end
end
