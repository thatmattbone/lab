defmodule KV.Registry do
  use GenServer

  ## Client api goes here


  @impl true
  def init(:ok) do
    {:ok, %{}}
  end

  @impl true
  def handle_call({:lookup, name}, _from, names) do
    {:reply, Map.fetch(names, name), names}
  end

  @impl true
  def handle_cast({:create, name}, names) do
    {:ok, bucket} = KV.Bucket.start_link([])
    {:noreply, Map.put(names, name, bucket)}
  end

end