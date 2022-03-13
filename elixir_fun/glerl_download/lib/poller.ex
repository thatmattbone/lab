defmodule GlerlPoller do
  use GenServer

  def start_link(state) do
    IO.puts("GlerlPoller.start_link/1")
    IO.inspect(state)
    # server = Keyword.fetch!(opts, :name)
    GenServer.start_link(__MODULE__, state, name: __MODULE__)
  end

  def init(init_arg) do
    IO.puts("GlerlPoller.init/1")
    IO.inspect(init_arg)

    schedule_work()

    {:ok, init_arg}
  end

  def handle_info(:poll, state) do
    IO.puts("...doing my polling work...")

    schedule_work()

    {:noreply, state}
  end

  defp schedule_work() do
    # 2 * 60 * 60 * 1000 # In 2 hours
    Process.send_after(self(), :poll, 10 * 1000)
  end
end
