defmodule Demo.Scene.Fills do
  use Scenic.Scene

  alias Scenic.Graph
  # alias Scenic.Assets.Static
  alias Scenic.Assets.Stream
  alias Scenic.Assets.Stream.Bitmap

  import Scenic.Primitives

  alias Demo.Component.Nav
  alias Demo.Component.Notes

  @body_offset 70

  @notes """
    \"Fills\" is a simple scene that demonstrates the different fill types.
  """

  @interval_r 37
  @interval_g 40
  @interval_b 50
  @interval_draw 200

  @width 10
  @height 10

  @start_color {0, 0, 0}
  @stream "fill_stream"
  @parrot :parrot

  @moduledoc """
  This version of `Fills` shows a variety of fills, including
  images, a stream, and more.
  """

  # import IEx

  # ============================================================================
  # setup

  # --------------------------------------------------------
  @doc false
  @impl Scenic.Scene
  def init(scene, _param, _opts) do
    # build the graph
    graph =
      Graph.build(font: :roboto, font_size: 24)
      # text input
      |> group(
        fn graph ->
          graph
          |> rect({100, 60}, t: {0, 0}, fill: :blue)
          |> rect({100, 60}, t: {0, 70}, fill: {:color, :green})
          |> rect({100, 60}, t: {0, 140}, fill: {:image, @parrot})
          |> rect({100, 60}, t: {0, 210}, fill: {:stream, @stream})
          |> rect({100, 60}, t: {0, 280}, fill: {:linear, {0, 0, 100, 40, :red, :green}})
          |> rect({100, 60}, t: {0, 350}, fill: {:radial, {50, 40, 0, 50, :red, :green}})
        end,
        translate: {40, @body_offset}
      )
      |> group(
        fn graph ->
          graph
          |> text("fill: :blue", t: {0, 0})
          |> text("fill: {:color, :green}", t: {0, 70})
          |> text("fill: {:image, #{inspect(@parrot)}}", t: {0, 140})
          |> text("fill: {:stream, #{inspect(@stream)}}", t: {0, 210})
          |> text("fill: {:linear, {0, 0, 100, 40, :red, :green}}", t: {0, 280})
          |> text("fill: {:radial, {50, 40, 0, 50, :red, :green}}", t: {0, 350})
        end,
        translate: {160, @body_offset + 40}
      )
      # NavDrop and Notes are added last so that they draw on top
      |> Nav.add_to_graph(__MODULE__)
      |> Notes.add_to_graph(@notes)

    :timer.send_interval(@interval_r, self(), :cycle_r)
    :timer.send_interval(@interval_g, self(), :cycle_g)
    :timer.send_interval(@interval_b, self(), :cycle_b)
    :timer.send_interval(@interval_draw, self(), :draw)

    texture =
      Bitmap.build( :rgb, @width, @height, clear: @start_color, commit: true )
      |> Stream.put!( @stream )

    scene =
      scene
      |> assign( color: @start_color, texture: texture )
      |> push_graph(graph)

    {:ok, scene}
  end

  # --------------------------------------------------------
  @doc false
  @impl GenServer
  def handle_info(:cycle_r, %{assigns: %{color: {r, g, b}}} = scene) do
    { :noreply, assign(scene, :color, {rem(r + 1, 256), g, b}) }
  end

  def handle_info(:cycle_g, %{assigns: %{color: {r, g, b}}} = scene) do
    { :noreply, assign(scene, :color, {r, rem(g + 1, 256), b}) }
  end

  def handle_info(:cycle_b, %{assigns: %{color: {r, g, b}}} = scene) do
    { :noreply, assign(scene, :color, {r, g, rem(b + 1, 256)}) }
  end

  def handle_info(:draw, %{assigns: %{color: color, texture: texture}} = scene) do
    texture =
      texture
      |> Bitmap.mutable()
      |> Bitmap.clear( color )
      |> Bitmap.commit()
      |> Stream.put!( @stream )

    {:noreply, assign(scene, :texture, texture)}
  end

end
