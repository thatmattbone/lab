defmodule ProtocolExplorationTest do
  use ExUnit.Case
  doctest ProtocolExploration.StaticSquare

  test "static square description" do
    assert ProtocolExploration.StaticSquare.description() == "I am a static, 100 by 100 square."
  end
end
