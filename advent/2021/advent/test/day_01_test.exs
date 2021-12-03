defmodule Day01Test do
  use ExUnit.Case
  doctest Day01

  test "day 01, part 1" do
    assert Day01.part1() == 1462
  end

  test "sliding window" do
    assert Day01.sliding_window([1, 2, 3]) == [6]
    assert Day01.sliding_window([1, 2, 3, 4, 5]) == [6, 9, 12]
  end

  test "day 01, part 2" do
    assert Day01.part2() == 1497
  end
end
