defmodule ProtocolExplorationTest do
  use ExUnit.Case
  doctest ProtocolExploration.StaticSquare

  test "static square description" do
    assert ProtocolExploration.StaticSquare.description() == "I am a static, 100 by 100 square."
  end

  test "static square height" do
    assert ProtocolExploration.Dimensions.height(%ProtocolExploration.StaticSquare{}) == 100
  end

  test "static square width" do
    assert ProtocolExploration.Dimensions.width(%ProtocolExploration.StaticSquare{}) == 100
  end

  test "square height & width" do
    square = %ProtocolExploration.Square{size: 555}

    assert ProtocolExploration.Dimensions.height(square) == 555
    assert ProtocolExploration.Dimensions.width(square) == 555
  end

end
