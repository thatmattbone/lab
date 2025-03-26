defmodule HeadsUpWeb.IncidentLive.Index do
  use HeadsUpWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, incidents: HeadsUp.Incident.list_incidents())}
  end

  def render(assigns) do
    ~H"""
      <div class="incident-index">
        <div class="incidents">
          <div class="card">
            <img src="/images/bear-in-trash.jpg" />
            <h2>Bear In The Trash</h2>
            <div class="details">
              <div class="badge">
                canceled
              </div>
              <div class="priority">
                1
              </div>
            </div>
          </div>
        </div>
      </div>
    """
  end
end
