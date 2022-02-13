defmodule Glerl.Application do
  use Application

  @impl true
  def start(_type, _args) do
    #KV.Supervisor.start_link(name: KV.Supervisor)
    IO.puts("in the app.start")

    {:ok, self()}
  end
end
