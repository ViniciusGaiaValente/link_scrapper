defmodule  LinkScraper.Adapters.HTTPAdapter do
  @moduledoc """
  Adapter to handle http requests
  """

  @spec fetch_html(binary) :: {:error, any} | {:ok, String.t()}
  @doc """
  Perform a http get request and return the html recieved
  """
  def fetch_html(url) do
    with {:ok, %{body: body}} <- Tesla.get(url) do
      {:ok, body}
    end
  end
end
