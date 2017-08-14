defmodule TimexPoison.Mixfile do
  use Mix.Project

  def project do
    [app: :timex_poison,
     version: "0.1.1",
     elixir: "~> 1.4",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     consolidate_protocols: Mix.env != :test,
     deps: deps(),
     package: package()
    ]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:logger, :timex]]
  end

  defp package do
    [
      licenses: ["BSD"],
      maintainers: ["Andrew Harvey"],
      links: %{
        "GitHub" => "https://github.com/zovafit/timex_poison"
      },
      description: description()
    ]
  end

  defp description do
    """
    Easily parse timestamps using Timex as they are decoded from json by Poison.
    """
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
      {:timex, "~> 3.1"},
      {:poison, "~> 1.5 or ~> 2.0 or ~> 3.0"},
      {:ex_doc, ">= 0.0.0", only: :dev}
    ]
  end
end
