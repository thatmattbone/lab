defmodule ProtocolExplorationTest do
  use ExUnit.Case

  alias ProtocolExploration.StaticSquare
  alias ProtocolExploration.Dimensions
  alias ProtocolExploration.Square
  alias ProtocolExploration.Rectangle

  test "static square description" do
    assert StaticSquare.description() == "I am a static, 100 by 100 square."
  end

  test "static square height" do
    assert Dimensions.height(%StaticSquare{}) == 100
  end

  test "static square width" do
    assert Dimensions.width(%StaticSquare{}) == 100
  end

  test "square height & width" do
    square = %Square{size: 555}

    assert Dimensions.height(square) == 555
    assert Dimensions.width(square) == 555
  end

  test "rectangle height & width" do
    rect = %Rectangle{height: 250, width: 750}

    assert Dimensions.height(rect) == 250
    assert Dimensions.width(rect) == 750
  end
end
