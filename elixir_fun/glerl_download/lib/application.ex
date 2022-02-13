defmodule Glerl.Application do
  use Application

  @impl true
  def start(type, args) do
    IO.puts("Glerl.Application.start/2")
    IO.inspect(type)
    IO.inspect(args)

    # Glerl.Supervisor.start_link(foo: :bar)
    Glerl.Supervisor.start_link(%{})
  end
end
