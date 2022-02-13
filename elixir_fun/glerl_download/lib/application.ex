defmodule Glerl.Application do
  use Application

  @impl true
  def start(_type, _args) do
    Glerl.Supervisor.start_link(foo: :bar)
  end
end
