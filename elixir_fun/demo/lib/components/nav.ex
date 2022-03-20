defmodule Demo.Component.Nav do
  use Scenic.Component

  alias Scenic.ViewPort
  alias Scenic.Graph

  import Scenic.Primitives, only: [{:text, 3}, {:rect, 3}]
  import Scenic.Components, only: [{:dropdown, 3}, {:toggle, 3}]
  import Scenic.Clock.Components

  # import IEx

  @height 60

  # --------------------------------------------------------
  @doc false
  @impl Scenic.Component
  def validate(scene) when is_atom(scene), do: {:ok, scene}
  def validate({scene, _} = data) when is_atom(scene), do: {:ok, data}

  def validate(data) do
    {
      :error,
      """
      #{IO.ANSI.red()}Invalid PonchoScenic.Component.Nav specification
      Received: #{inspect(data)}
      #{IO.ANSI.yellow()}
      Nav component requires a valid scene module or {module, param}
      """
    }
  end

  # --------------------------------------------------------
  @doc false
  @impl Scenic.Scene
  def init(scene, current_scene, opts) do
    {width, _height} = scene.viewport.size

    {background, text} =
      case opts[:theme] do
        :dark ->
          {{48, 48, 48}, :white}

        :light ->
          {{220, 220, 220}, :black}

        _ ->
          {{48, 48, 48}, :white}
      end

    graph =
      Graph.build(font_size: 20)
      |> rect({width, @height}, fill: background)
      |> text("Scene:", translate: {15, 38}, align: :right, fill: text)
      |> dropdown(
        {[
           {"Sensor", Demo.Scene.Sensor},
           {"Sensor (spec)", Demo.Scene.SensorSpec},
           {"Primitives", Demo.Scene.Primitives},
           {"Fills", Demo.Scene.Fills},
           {"Strokes", Demo.Scene.Strokes},
           {"Components", Demo.Scene.Components},
           {"Transforms", Demo.Scene.Transforms},
           {"Sprites", Demo.Scene.Sprites},
           {"Testing", Demo.Scene.Testing}
          ], current_scene},
        id: :nav,
        translate: {90, 10}
      )
      |> toggle(
        opts[:theme] == :light,
        id: :light_or_dark,
        theme: :secondary,
        translate: {width - 60, 16}
      )
      |> digital_clock(styles: [text_align: :center], translate: {width/2, 35})

    scene = push_graph(scene, graph)

    { :ok, scene }
  end

  # --------------------------------------------------------
  @impl Scenic.Scene
  def handle_event({:value_changed, :nav, {scene_mod, param}}, _, scene) do
    ViewPort.set_root(scene.viewport, scene_mod, param)
    {:noreply, scene}
  end

  def handle_event({:value_changed, :nav, scene_mod}, _, scene) do
    ViewPort.set_root(scene.viewport, scene_mod)
    {:noreply, scene}
  end

  def handle_event({:value_changed, :light_or_dark, light?}, _, scene) do
    case light? do
      true -> ViewPort.set_theme(scene.viewport, :light)
      false -> ViewPort.set_theme(scene.viewport, :dark)
    end

    {:noreply, scene}
  end
end
