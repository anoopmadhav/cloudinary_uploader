defmodule CloudinaryUploader.Mixfile do
  use Mix.Project

  def project do
    [
      app: :cloudinary_uploader,
      version: "0.1.0",
      elixir: "~> 1.5",
      description: description(),
      start_permanent: Mix.env == :prod,
      deps: deps(),
      package: package()
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
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"},
      {:httpoison, "~> 0.13"},
      {:poison, "~> 3.1.0"},
      {:ex_doc, "~> 0.18.0", only: :dev},
      {:credo, "~> 1.1.0", only: :dev, runtime: false}
    ]
  end

  defp description do
    """
    A library to upload image, audio and video urls to Cloudinary.
    """
  end

  defp package do
    [
      maintainers: ["Anoop Madhav Bayana"],
      licenses: ["MIT"],
      files: ["lib", "mix.exs", "README*", "LICENSE*"],
      links: %{
        "GitHub" => "https://github.com/anoopmadhav/cloudinary_uploader"
      }
    ]
  end
end
