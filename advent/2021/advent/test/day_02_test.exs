defmodule Day02Test do
  use ExUnit.Case
  doctest Day02

  test "day 02, part 1" do
    assert Day02.part1() == 2039912
  end

  test "day 02, part 2" do
    assert Day02.part2() == 1942068080
  end
end
