defmodule HeadsUpWeb.IncidentLive.Index do
  use HeadsUpWeb, :live_view
  import HeadsUpWeb.CustomComponents

  def mount(_params, _session, socket) do
    {:ok, assign(socket, incidents: HeadsUp.Incident.list_incidents(), page_title: "Incidents")}
  end


#<:tagline :let={vibe}>
#  Thanks for pitching in. <%= vibe %>
#</:tagline>

  def render(assigns) do
    ~H"""
      <.headline>
        <.icon name="hero-trophy-mini" />
        25 Incidents Resolved This Month!

        <:tagline :let={vibe}>
          Thanks for pitching in. <%= vibe %>
        </:tagline>
      </.headline>

      <.headline>
        My Headline

        <:tagline>
          Thanks for pitching in.
        </:tagline>

        <:tagline>
          It really means a lot.
        </:tagline>
        </.headline>

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
end
