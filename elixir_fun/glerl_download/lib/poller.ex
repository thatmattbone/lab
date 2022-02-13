defmodule GlerlPoller do
  use GenServer

  def start_link(opts) do
    IO.puts("GlerlPoller.start_link/1")
    IO.inspect(opts)
    # server = Keyword.fetch!(opts, :name)
    GenServer.start_link(__MODULE__, __MODULE__, opts)
  end

  def init(init_arg) do
    IO.puts("GlerlPoller.init/1")

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
