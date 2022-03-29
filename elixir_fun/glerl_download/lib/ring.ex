defmodule Ring do
  defstruct [
    :data_map,
    :current_position,
    :length
  ]

  def new(size) do
    %Ring{
      data_map: (for i <- 0..(size - 1), into: %{}, do: {i, nil}),
      current_position: 0,
      length: size
    }
  end


  def push(ring = %Ring{}, obj) do
    %Ring{
      data_map: Map.put(ring.data_map, ring.current_position, obj),
      current_position: rem(ring.current_position + 1, ring.length),
      length: ring.length
    }
  end

end
