defmodule HeadsUpWeb.IncidentLive.Index do
  use HeadsUpWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, incidents: HeadsUp.Incident.list_incidents())}
  end


  def render(assigns) do
    ~H"""
      <div class="incident-index">
        <div class="incidents">
          <.card :for={incident <- @incidents} incident={incident} />
        </div>
      </div>
    """
  end

  attr :incident, HeadsUp.Incident, required: true
  def card(assigns) do
    ~H"""
      <div class="card">
        <img src={@incident.image_path}} />
        <h2><%= @incident.name %></h2>
        <div class="details">
          <.badge status={@incident.status}/>
          <div class="priority">
            <%= @incident.priority %>
          </div>
        </div>
      </div>
    """
  end


  attr :status, :atom, required: true
  def badge(assigns) do
    # was class="badge" before the tailwind bullshit.
    ~H"""
      <div class={[
        "rounded-md px-2 py-1 text-xs font-medium uppercase inline-block border",
        @status == :resolved && "text-lime-600 border-lime-600",
        @status == :pending && "text-amber-600 border-amber-600",
        @status == :canceled && "text-gray-600 border-gray-600"
        ]}>
        <%= @status %>
      </div>
    """
  end
end
