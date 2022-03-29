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
    IO.inspect(ring.current_position)
    IO.inspect(ring.length)
    IO.inspect(ring.data_map)

    IO.inspect(obj)
    
    ring
  end

end
