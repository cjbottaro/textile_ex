defmodule TextileTest do
  use ExUnit.Case
  doctest Textile

  test "basic example" do
    textile = """
    h2. Textile

    * is a _shorthand syntax_ used to generate valid HTML
    * is *easy* to read and *easy* to write
    * can generate complex pages, including: headings, quotes, lists, tables and figures

    Textile integrations are available for "a wide range of platforms":/article/.
    """

    html = """
    <h2>Textile</h2>

    <ul>
      <li>is a <em>shorthand syntax</em> used to generate valid <span class="caps">HTML</span></li>
      <li>is <strong>easy</strong> to read and <strong>easy</strong> to write</li>
      <li>can generate complex pages, including: headings, quotes, lists, tables and figures</li>
    </ul>

    <p>Textile integrations are available for <a href="/article/">a wide range of platforms</a>.</p>
    """

    expected = html |> String.replace(~r/\s+/, "")
    actual = Textile.render(textile) |> String.replace(~r/\s+/, "")

    assert expected == actual
  end

end
