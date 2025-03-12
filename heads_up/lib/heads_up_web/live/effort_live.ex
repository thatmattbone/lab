defmodule HeadsUpWeb.EffortLive do
  use HeadsUpWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, num_of_responders: 1, avg_minutes: 5)}
  end

  def render(assigns) do
    ~H"""
      <div class="effort">
        <h1>Community Love</h1>
        <section>
          <button phx-click="add">
            + 1
          </button>
          <div>
            <%= @num_of_responders %>
          </div>
          &times;
          <div>
            <%= @avg_minutes %>
          </div>
          =
          <div>
            <%= @num_of_responders * @avg_minutes %>
          </div>
        </section>

        <form phx-submit="recalculate">
          <label>Minutes Per Responder:</label>
          <input type="number" name="avg_minutes" value={@avg_minutes} />
        </form>
      </div>
    """
  end

  def handle_event("add", _, socket) do
    #new_num_of_responders = socket.assigns.num_of_responders + 1
    #socket = assign(socket, num_of_responders: new_num_of_responders)
    #socket = update(socket, :num_of_responders, fn num_of_responders -> num_of_responders + 1 end)
    socket = update(socket, :num_of_responders, &(&1 + 1))
    {:noreply, socket}
  end

  def handle_event("recalculate", %{"avg_minutes" => avg_minutes} = _params, socket) do
    socket = assign(socket, avg_minutes: String.to_integer(avg_minutes))

    {:noreply, socket}
  end
end
