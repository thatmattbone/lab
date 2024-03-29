defmodule Demo.Scene.Sprites do
  @moduledoc """
  Sample scene.
  """
  use Scenic.Scene
  alias Scenic.Graph
  alias Demo.Component.Nav

  import Scenic.Primitives
  import Scenic.Components

  @image "images/fairy_grove.jpg"

  @wh 40
  @nx 16
  @ny 10

  # --------------------------------------------------------
  @doc false
  @impl Scenic.Scene
  def init(scene, _param, _opts) do
    cmds = cmds(@nx, @ny, 0)

    graph =
      Graph.build()
      |> group(
        fn g ->
          g
          |> slider({{0, 40}, 0}, id: :space, t: {80, 12})
          |> sprites({@image, cmds}, id: :sprites, t: {0, 40})
        end,
        t: {0, 60}
      )
      |> Nav.add_to_graph(__MODULE__)

    scene =
      scene
      |> assign(graph: graph)
      |> push_graph(graph)

    {:ok, scene}
  end

  # --------------------------------------------------------
  @doc false
  @impl Scenic.Scene
  # change the spacing
  def handle_event(
        {:value_changed, :space, sp},
        _,
        %{assigns: %{graph: graph}} = scene
      ) do
    cmds = cmds(@nx, @ny, sp)
    graph = Graph.modify(graph, :sprites, &sprites(&1, {@image, cmds}))

    scene =
      scene
      |> assign(graph: graph)
      |> push_graph(graph)

    {:noreply, scene}
  end

  # --------------------------------------------------------
  defp cmds(x, y, space) do
    # zero based counting, but x/y passed in are one based
    nx = x - 1
    ny = y - 1
    do_cmds(nx, ny, {nx, ny}, space, [])
  end

  defp do_cmds(0, 0, _xy, space, out) do
    [do_cmd(0, 0, space) | out]
  end

  defp do_cmds(0, y, {x, _} = xy, space, out) do
    out = [do_cmd(0, y, space) | out]
    do_cmds(x, y - 1, xy, space, out)
  end

  defp do_cmds(x, y, xy, space, out) do
    out = [do_cmd(x, y, space) | out]
    do_cmds(x - 1, y, xy, space, out)
  end

  defp do_cmd(x, y, space) do
    {
      {x * @wh, y * @wh},
      {@wh, @wh},
      {x * @wh + x * space, y * @wh + y * space},
      {@wh, @wh}
    }
  end
end
