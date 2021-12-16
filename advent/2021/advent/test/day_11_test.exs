defmodule Day11Test do
  use ExUnit.Case
  doctest Day11

  test "bump grid map" do
    assert Day11.bump_grid_map(%{{0, 0} => 1, {0, 1} => 2}) == %{{0, 0} => 2, {0, 1} => 3}
  end

  test "bump neighbors -- centered" do
    centered = %{
      {0, 0} => 1,
      {0, 1} => 1,
      {0, 2} => 1,
      {1, 0} => 2,
      {1, 1} => 9,
      {1, 2} => 2,
      {2, 0} => 3,
      {2, 1} => 3,
      {2, 2} => 3,
    }

    assert Day11.bump_neighbors(centered, {1, 1}) == %{
      {0, 0} => 2,
      {0, 1} => 2,
      {0, 2} => 2,
      {1, 0} => 3,
      {1, 1} => 9,
      {1, 2} => 3,
      {2, 0} => 4,
      {2, 1} => 4,
      {2, 2} => 4,
    }
  end

  test "bump neighbors -- corner" do
    corner = %{
      {0, 0} => 9,
      {0, 1} => 1,
      {0, 2} => 1,
      {1, 0} => 2,
      {1, 1} => 2,
      {1, 2} => 2,
      {2, 0} => 3,
      {2, 1} => 3,
      {2, 2} => 3,
    }

    assert Day11.bump_neighbors(corner, {0, 0}) == %{
      {0, 0} => 9,
      {0, 1} => 2,
      {0, 2} => 1,
      {1, 0} => 3,
      {1, 1} => 3,
      {1, 2} => 2,
      {2, 0} => 3,
      {2, 1} => 3,
      {2, 2} => 3,
    }
  end

  test "day 11, part 1" do
    assert Day11.part1() == 1
  end

  test "day 11, part 2" do
    assert Day11.part2() == 2
  end
end
