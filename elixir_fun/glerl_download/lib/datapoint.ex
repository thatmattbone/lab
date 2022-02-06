defmodule Datapoint do
  defstruct [
    :year,
    :doy,
    :utc,
    :temp_c,
    :speed,
    :gusts,
    :direction,
    :humidty
  ]
end
