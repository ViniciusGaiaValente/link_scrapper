defmodule LinkScraperTest do
  use ExUnit.Case
  import Mock

  describe "fetch" do
    test "fetches all available links from the page at specified url" do
      web_page_body = """
        <html>
          <body>

            <h1> This is definitely a web page </h1>

            <a href="https://externallink1.com"> Link 1 </a>

            <a href="https://externallink2.com"> Link 2 </a>

            <a href="https://externallink1.com"> Link 3 </a>

            <img src="https://sourceimage1.com"/>

            <img src="https://sourceimage2.com"/>

            <img src="https://sourceimage2.com"/>

          </body>
        </html>
      """

      with_mock Tesla, [get: fn(_url) -> {:ok, %{body: web_page_body}} end] do

        assert {:ok, %{links: links, assets: assets}} =
          LinkScraper.fetch("https://definitelyawebpage.com")

        assert Enum.sort(links) == ["https://externallink1.com", "https://externallink2.com"]
        assert Enum.sort(assets) == ["https://sourceimage1.com", "https://sourceimage2.com"]
      end
    end

    test "do not return the links that don`t have the right format" do
      web_page_body = """
        <html>
          <body>

            <h1> This is definitely a web page </h1>

            <a href="/not/a/external/link"> Link 1 </a>

            <a href="/not/a/external/link"> Link 2 </a>

            <a href="https://externallink.com"> Link 3 </a>

            <img src="data:hudge-pile-of-caracters"/>

            <img src="data:hudge-pile-of-caracters"/>

            <img src="https://sourceimage.com"/>

          </body>
        </html>
      """

      with_mock Tesla, [get: fn(_url) -> {:ok, %{body: web_page_body}} end] do

        assert {:ok, %{links: links, assets: assets}} =
          LinkScraper.fetch("https://definitelyawebpage.com")

        assert Enum.sort(links) == ["https://externallink.com"]
        assert Enum.sort(assets) == ["https://sourceimage.com"]
      end
    end
  end
end
