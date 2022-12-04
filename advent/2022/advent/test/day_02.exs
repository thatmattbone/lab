defmodule Day02Test do
  use ExUnit.Case

  test "day02, part 1, example" do
    assert Day02.part1_example() == 15
  end

  test "day02, part 1" do
    assert Day02.part1() == 12679
  end

end
