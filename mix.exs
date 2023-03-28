defmodule Textile.MixProject do
  use Mix.Project

  def project do
    [
      app: :textile,
      version: "0.1.0",
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      docs: [
        main: "Textile"
      ],
      source_url: "https://github.com/cjbottaro/textile_ex",
      package: package(),
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
    [
      {:rustler_precompiled, "~> 0.6.1"},
      {:rustler, "~> 0.27.0", optional: true},
      {:ex_doc, "~> 0.27", only: :dev, runtime: false},
    ]
  end

  defp package() do
    [
      maintainers: ["Christopher Bottaro"],
      licenses: ["Unlicense"],
      links: %{"GitHub" => "https://github.com/cjbottaro/textile_ex"},
      files: [
        "lib",
        "mix.exs",
        "README*",
        "native/textile/src",
        "native/textile/.cargo",
        "native/textile/README*",
        "native/textile/Cargo*",
        "checksum-*.exs"
      ]
    ]
  end
end
