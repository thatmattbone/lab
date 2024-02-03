defmodule ProtocolExploration.StaticSquare do
  def description() do
    "I am a static, 100 by 100 square."
  end

  @doc """
  Height of this static 100 x 100 square.
  ## Examples

      iex> ProtocolExploration.StaticSquare.height()
      100

  """
  def height do
    100
  end
end
