defmodule Day11Test do
  use ExUnit.Case
  doctest Day11

  test "bump grid map" do
    assert Day11.bump_grid_map(%{{0, 0} => 1, {0, 1} => 2}) == %{{0, 0} => 2, {0, 1} => 3}
  end

  test "day 11, part 1" do
    assert Day11.part1() == 1
  end

  test "day 11, part 2" do
    assert Day11.part2() == 2
  end
end
