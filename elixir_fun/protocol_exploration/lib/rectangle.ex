defmodule ProtocolExploration.Rectangle do
  defstruct [:width, :height]
end


defimpl ProtocolExploration.Dimensions, for: ProtocolExploration.Rectangle do
  def height(value) do
    value.height
  end

  def width(value) do
    value.width
  end
end
