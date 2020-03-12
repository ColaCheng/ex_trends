# ExTrends

This library provides an API layer to [google trends](https://trends.google.com/trends) data. It is constantly being expanded and improved so please check back frequently. Also, please feel free to contribute this project to make the library even better!

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `ex_trends` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:ex_trends, "~> 0.1.0"}
  ]
end
```

and run $ mix deps.get. Add :ex_trends to your applications list.

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