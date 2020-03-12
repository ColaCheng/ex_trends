# ExTrends

This library provides an API layer to [google trends](https://trends.google.com/trends) data. It is constantly being expanded and improved so please check back frequently. Also, please feel free to contribute this project to make the library even better!

## Installation

It can be installed by adding `ex_trends` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:ex_trends, "~> 0.1.0"}
  ]
end
```

and run `$ mix deps.get`. Add `:ex_trends` to your applications list.

```elixir
def application do
  [applications: [:ex_trends]]
end
```

## Usage

```elixir
iex> ExTrends.DailyTrends.request("TW") |> ExTrends.run()
{:ok,
  [
    %{
        "articles" => [...],
        "formattedTraffic" => "100K+",
        "image" => %{...},
        "relatedQueries" => [...],
        "shareUrl" => "",
        "title" => %{...}
    },...
  ]
}
iex> ExTrends.DailyTrends.request("TW") |> ExTrends.run!()
[
  %{
    "articles" => [...],
    "formattedTraffic" => "100K+",
    "image" => %{...},
    "relatedQueries" => [...],
    "shareUrl" => "",
    "title" => %{...}
  },...
]
```

## Big Thanks

This library got a lot of help from those libraries to figure out the google trends API.

- [google-trends-api](https://github.com/pat310/google-trends-api)(Node.js)
- [pytrends](https://github.com/GeneralMills/pytrends)(Python)

## License

```
MIT License

Copyright (c) 2020 colacheng

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```