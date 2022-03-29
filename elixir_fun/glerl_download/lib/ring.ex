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

  def fix_index(index, size) when index < size do  # TODO make this private? why didn't that work?
    index
  end

  def fix_index(index, size) do
    index - size
  end

  def to_list(ring = %Ring{}) do
    # should probably reverse this??
    for i <- ring.current_position..(ring.current_position + ring.length - 1) do
      fixed_i = Ring.fix_index(i, ring.length)
      Map.get(ring.data_map, fixed_i)
    end
  end

end

defimpl Enumerable, for: Ring do

end
