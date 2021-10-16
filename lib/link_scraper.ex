defmodule LinkScraper do
  @moduledoc """
  Module to wrap web scrape functions
  """

  alias Floki
  alias LinkScraper.Adapters.HTTPAdapter

  @spec fetch(binary) :: {:error, any} | {:ok, %{assets: [String.t()], links: [String.t()]}}
  @doc """
  Fetches a url from a given page and extract all the links present on the a tags and img tags
  """
  def fetch(url) do
    with {:ok, body} <- HTTPAdapter.fetch_html(url),
         {:ok, document} <- Floki.parse_document(body) do
      links =
        document
        |> Floki.find("a")
        |> Floki.attribute("a", "href")
        |> extract_links()

      assets =
        document
        |> Floki.find("img")
        |> Floki.attribute("img", "src")
        |> extract_links()

      {:ok, %{
        assets: assets,
        links: links
      }}
    end
  end

  defp extract_links(list) do
    list
    |> Enum.reduce([], fn link, result ->
      case link do
        "http" <> _ ->
          List.insert_at(result, 0, link)
        _ ->
          result
      end
    end)
    |> Enum.uniq()
  end
end
