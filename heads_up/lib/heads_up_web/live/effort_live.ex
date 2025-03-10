defmodule HeadsUpWeb.EffortLive do
  use HeadsUpWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, num_of_responders: 2, avg_minutes: 5)}
  end

  def render(assigns) do
    ~H"""
      <div class="effort">
        <h1>Community Love</h1>
        <section>
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
      </div>
    """
  end
end
