defmodule Day10Test do
  use ExUnit.Case
  doctest Day10

  test "corrupt empty stack" do
    {:corrupt, val} = Day10.line_info(["}"], [])
    assert val == "}"
  end

  test "incomplete stack" do
    {:incomplete, val} = Day10.line_info(["[", "{", "<"], [])
    assert val == 3
  end

  test "day 10, part 1" do
    assert Day10.part1() == 1
  end


  test "day 10, part 2" do
    assert Day10.part2() == 2
  end
end
