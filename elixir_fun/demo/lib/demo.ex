defmodule Demo do
  @moduledoc """
  Starter application using the Scenic framework.
  """

  def start(_type, _args) do
    # load the viewport configuration from config
    main_viewport_config = Application.get_env(:demo, :viewport)

    fuck = Application.get_env(:demo, :fuck)
    IO.puts(fuck)

    # start the application with the viewport
    children = [
      {Scenic, [main_viewport_config]},
      Demo.Sensors.Supervisor
    ]

    Supervisor.start_link(children, strategy: :one_for_one)
  end
end
