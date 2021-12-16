defmodule Day09Test do
  use ExUnit.Case
  doctest Day09

  test "day 09, part 1" do
    assert Day09.part1() == 478
  end

  test "day 09, part 2" do
    assert Day09.part2() == 1327014
  end
end
