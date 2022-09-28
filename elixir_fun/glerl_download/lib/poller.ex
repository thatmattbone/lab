defmodule GlerlPoller do
  use GenServer

  @poll_every 30 * 1000  # 30 seconds

  def start_link(state) do
    IO.puts("GlerlPoller.start_link/1")
    IO.inspect(state)
    # server = Keyword.fetch!(opts, :name)
    GenServer.start_link(__MODULE__, state, name: __MODULE__)
  end

  def init(init_arg) do
    IO.puts("GlerlPoller.init/1")
    IO.inspect(init_arg)

    send(self(), :poll)

    {:ok, init_arg}
  end

  def handle_info(:poll, state) do
    IO.puts("...doing my polling work...")

    todays_data = LiveDownloader.fetch_todays_file()
    IO.inspect(todays_data)

    schedule_work()
    {:noreply, state}
  end

  defp schedule_work() do
    Process.send_after(self(), :poll, @poll_every)
  end
end
