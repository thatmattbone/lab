defmodule Demo.Scene.Testing do
  use Scenic.Scene

  alias Scenic.Graph

  import Scenic.Primitives

  alias Demo.Component.Nav
  alias Demo.Component.Notes

  @notes """
  ...these are some notes...
  """

  @impl Scenic.Scene
  def init(scene, _param_, _opts) do
    {width, height} = scene.viewport.size

    IO.puts("scene width: #{width}")
    IO.puts("scene height: #{height}")

    graph = Graph.build(font: :roboto, font_size: 24)
      |> text("Hello World", text_align: :center, translate: {300, 300})
      |> circle(100, stroke: {2, :green}, translate: {100, 100})

      |> Nav.add_to_graph(__MODULE__)
      |> Notes.add_to_graph(@notes)

    scene =
      scene
      |> assign(:graph, graph)
      |> push_graph(graph)

    {:ok, scene}
  end
end
