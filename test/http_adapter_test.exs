defmodule LinkScraper.Adapters.HTTPAdapter.Test do
  use ExUnit.Case
  import Mock
  import LinkScraper.Adapters.HTTPAdapter

  describe "fetch_html" do
    test "fetches a page correctly" do
      web_page_body = "<html> <body> <h1> This is definitely a web page </h1> </body> </html>"

      with_mock Tesla, [get: fn(_url) -> {:ok, %{body: web_page_body}} end] do
        assert {:ok, web_page_body} == fetch_html("https://definitelyawebpage.com")
      end
    end
  end
end
