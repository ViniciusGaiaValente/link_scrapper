# LinkScraper

Simple module to scrape all the links and source images from a web page

### Limitations

- May does not work correctly on pages that rely on javascript
- May does not work correctly on pages that block requests that don't come from browsers

### Running the project

In order to fetch some URLs you should run the following commands on the project folder:

```bash
  mix deps.get
  iex -S mix
```

Then:

```elixir
  LinkScraper.fetch("<insert the URL here>")
```
  
### Testing

To run the test suite type the following commands on the project folder:

```bash
  mix deps.get
  mix test
```
