defmodule GlerlPoller do
  use GenServer

  def start_link(opts) do
    IO.puts("fuck")
    IO.inspect(opts)
    #server = Keyword.fetch!(opts, :name)
    GenServer.start_link(__MODULE__, :foo, opts)
  end
end
