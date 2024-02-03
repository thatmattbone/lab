defmodule ProtocolExploration.StaticSquare do
  defstruct []

  def description() do
    "I am a static, 100 by 100 square."
  end
end


defimpl ProtocolExploration.Dimensions, for: ProtocolExploration.StaticSquare do
  def height(_value) do
    100
  end

  def width(_value) do
    100
  end
end
