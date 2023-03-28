defmodule Textile do
  @moduledoc """
  Render Textile to HTML using [Rustextile](https://crates.io/crates/rustextile).

      iex> Textile.render \"""
        h2. Textile

        * is a _shorthand syntax_ used to generate valid HTML
        * is *easy* to read and *easy* to write
        * can generate complex pages, including: headings, quotes, lists, tables and figures

        Textile integrations are available for "a wide range of platforms":/article/.
      \"""

      \"""
      <h2>Textile</h2>

      <ul>
        <li>is a <em>shorthand syntax</em> used to generate valid <span class="caps">HTML</span></li>
        <li>is <strong>easy</strong> to read and <strong>easy</strong> to write</li>
        <li>can generate complex pages, including: headings, quotes, lists, tables and figures</li>
      </ul>

      <p>Textile integrations are available for <a href="/article/">a wide range of platforms</a>.</p>
      \"""

  """

  source_url = Mix.Project.config()[:source_url]
  version = Mix.Project.config()[:version]

  use RustlerPrecompiled, otp_app: :textile,
    base_url: "#{source_url}/releases/download/v#{version}",
    force_build: System.get_env("FORCE_TEXTILE_BUILD") in ["1", "true"],
    targets: RustlerPrecompiled.Config.default_targets(),
    nif_versions: ["2.16", "2.15"],
    version: version

  @typedoc """
  Render options.
  """
  @type options :: [
    {:html_kind, :html5 | :xhtml},
    {:restricted, boolean},
    {:sanitize, boolean}
  ]

  @doc """
  Render Textile to HTMl.

  The options directly correspond to
  [Rustextile](https://docs.rs/rustextile/1.0.2/rustextile/struct.Textile.html)
  options.

  ## Options

    * `:html_kind` Either `:html5` or `:xhtml`. Defaults to `:html5`.
    * `:restricted` Escape dangerous HTML entities. Default `false`.
    * `:sanitize` Remove dangerous HTML entities. Default `false`.

  ## Examples

      iex> Textile.render("<script>foo</script>")
      "<p><script>foo</script></p>"

      iex> Textile.render("<script>foo</script>", restricted: true)
      "<p>&lt;script&gt;foo&lt;/script&gt;</p>"

      iex> Textile.render("<script>foo</script>", sanitize: true)
      "<p></p>"

  """
  @spec render(binary, options) :: binary
  def render(textile, opts \\ []) when is_binary(textile) do
    html_kind = Keyword.get(opts, :html_kind, :html5)
    |> to_string()

    args = [html_kind]
    |> add_arg(opts, :restricted)
    |> add_arg(opts, :sanitize)

    do_render(textile, args)
  end

  defp add_arg(args, opts, key) do
    if opts[key] do
      [to_string(key) | args]
    else
      args
    end
  end

  defp do_render(_string, _args), do: :erlang.nif_error(:nif_not_loaded)
end
