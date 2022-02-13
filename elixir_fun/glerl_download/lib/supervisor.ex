defmodule Glerl.Supervisor do
  use Supervisor

  def start_link(init_arg) do
    IO.puts("Glerl.Supervisor.start_link/")
    IO.inspect(init_arg)

    Supervisor.start_link(__MODULE__, init_arg, name: __MODULE__)
  end

  @impl true
  def init(init_arg) do
    IO.puts("Glerl.Supervisor.init/1")
    IO.inspect(init_arg)

    children = [
      # {DynamicSupervisor, name: KV.BucketSupervisor, strategy: :one_for_one},
      GlerlPoller
    ]

    Supervisor.init(children, strategy: :one_for_all)
  end
end
