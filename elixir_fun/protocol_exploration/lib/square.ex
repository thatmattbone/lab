defmodule ProtocolExploration.Square do
  defstruct [:size]
end


defimpl ProtocolExploration.Dimensions, for: ProtocolExploration.Square do
  def height(value) do
    value.size
  end

  def width(value) do
    value.size
  end
end
