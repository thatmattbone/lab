defmodule HeadsUpWeb.IncidentLive.Index do
  use HeadsUpWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, incidents: HeadsUp.Incident.list_incidents())}
  end

  def render(assigns) do
    ~H"""
      <div class="incident-index">
        <div class="incidents">
          <div :for={incident <- @incidents} class="card">
            <img src={incident.image_path}} />
            <h2><%= incident.name %></h2>
            <div class="details">
              <div class="badge">
                <%= incident.status %>
              </div>
              <div class="priority">
                <%= incident.priority %>
              </div>
            </div>
          </div>
        </div>
      </div>
    """
  end
end
