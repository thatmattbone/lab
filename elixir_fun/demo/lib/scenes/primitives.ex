defmodule Demo.Scene.Primitives do
  @moduledoc """
  Sample scene.
  """

  use Scenic.Scene
  alias Scenic.Graph
  import Scenic.Primitives

  alias Demo.Component.Nav
  alias Demo.Component.Notes

  @notes """
    \"Primitives\" shows the various primitives available in Scenic.
    It also shows a sampling of the styles you can apply to them.
  """

  ##
  # In this example we specify all the components statically using
  # module attributes. When we say
  #
  #       @lines [
  #        line_spec(@line, stroke: {4, :red}),
  #        line_spec(@line, stroke: {20, :green}, cap: :butt, t: {60, 0}),
  #        line_spec(@line, stroke: {20, :yellow}, cap: :round, t: {120, 0})
  #      ]
  #
  # We're not yet drawing anything. Instead we'd creating
  # _specifications_ for things that we will be adding to
  # the display graph when the code runs.
  #
  # This use of module attributes to create the things we'll be
  # displaying later is a common scenic idiom.
  ##

  @bird_width 100
  @bird_height 128

  @body_offset 80

  # this is not a primitive: it's just the
  @line {{0, 0}, {60, 60}}
  # a parameter that's common to the three
  # `line_spec`s that follow

  ##
  # Remember that what gets rendered is a display graph. It's defined
  # recursively, so each of its nodes can be either a display graph, a
  # list of primitives, or a primitive itself. So, when we create a list
  # of lines here, the result can simply be added to the graph as a
  # single node.

  @lines [
    line_spec(@line, stroke: {4, :red}),
    line_spec(@line, stroke: {20, :green}, cap: :butt, t: {60, 0}),
    line_spec(@line, stroke: {20, :yellow}, cap: :round, t: {120, 0})
  ]

  ##
  # Same for other shapes

  @triangle_circle_ellipse [
    triangle_spec({{0, 60}, {50, 0}, {50, 60}}, fill: :khaki, stroke: {4, :green}),
    circle_spec(30, fill: :red, stroke: {6, :yellow}, t: {110, 30}),
    ellipse_spec({30, 40}, fill: :green, stroke: {4, :gray}, t: {200, 30})
  ]

  @quads [
    rect_spec(
      {50, 60},
      fill: :khaki,
      stroke: {4, :green}
    ),
    rrect_spec(
      {50, 60, 6},
      fill: :green,
      stroke: {6, :yellow},
      t: {85, 0}
    ),
    quad_spec(
      {{0, 100}, {160, 0}, {300, 110}, {200, 260}},
      id: :quad,
      fill: {:image, :parrot},
      stroke: {10, :khaki},
      translate: {400, 0},
      # pin: {0, 0}
      rotate: -0.3
    ),
    sector_spec(
      {100, 0.5},
      stroke: {3, :grey},
      fill: {:radial, {0, 0, 20, 160, {:yellow, 128}, {:purple, 128}}},
      translate: {250, 20}
    ),
    arc_spec(
      {120, -0.5},
      stroke: {6, :orange},
      translate: {270, 70}
    )
  ]

  @bird [
    rect_spec(
      {@bird_width, @bird_height},
      fill: {:image, :parrot},
      stroke: {4, :green},
      t: {15, 230}
    )
  ]

  @text [
    text_spec("Hello", translate: {0, 40}, font: :roboto, font_size: 50),
    text_spec("World", translate: {00, 80}, fill: :purple, font: :roboto_mono)
  ]

  @twisty_path path_spec(
                 [
                   :begin,
                   {:move_to, 0, 0},
                   {:bezier_to, 0, 20, 0, 50, 40, 50},
                   {:bezier_to, 60, 50, 60, 20, 80, 20},
                   {:bezier_to, 100, 20, 110, 0, 120, 0},
                   {:bezier_to, 140, 0, 160, 30, 160, 50}
                 ],
                 stroke: {2, :red},
                 translate: {500, 40}
               )

  ##
  # Now it's time to build the display graph. Again, this is
  # static, whih means it's done at compile time.
  #
  # We first create an empty graph (with some font attributes)
  # and then add to it all the specs we created above. Still
  # nothing gets drawn (as the code isn't actually running yet)

  @graph Graph.build(font: :roboto, font_size: 24)
         |> add_specs_to_graph(
           [
             text_spec("Various primitives and styles", translate: {15, 20}),
             group_spec(@lines, t: {290, 50}),
             group_spec(@triangle_circle_ellipse, t: {15, 50}),
             group_spec(@quads, t: {15, 130}),
             @bird,
             group_spec(@text, font_size: 30, t: {130, 240}),
             # @cycler,
             @twisty_path
           ],
           translate: {15, @body_offset}
         )

         # Nav and Notes are added last so that they draw on top
         |> Nav.add_to_graph(__MODULE__)
         |> Notes.add_to_graph(@notes)

  ##
  # And, finally, here's the code that executes at runtime. All it does
  # is load up the bird image, and push the previously constructed
  # graph into the scene.

  @doc false
  @impl Scenic.Scene
  def init(scene, _param, _opts) do
    {:ok, push_graph(scene, @graph)}
  end

end
