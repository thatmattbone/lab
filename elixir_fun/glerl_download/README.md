# GlerlDownload

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `glerl_download` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:glerl_download, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at <https://hexdocs.pm/glerl_download>.

## Run commands

Start the app and drop into the shell:
```iex -S mix```

Run our custom mix command to download the glerl archive:
```mix glerl```

## TODO

  - cleanup the module names and organization
  - more tests
  - make sure the supervisor tree setup makes sense and make sure the tree itself makes sense
  - figure out and setup some proper logging
  - text interface over a socket or something
