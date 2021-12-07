defmodule Day04Test do
  use ExUnit.Case
  doctest Day04
  doctest Day04Board

  test "create new board from grid" do
    %Day04Board{numbers: numbers} = Day04Board.new([
      [0,  1,  2,  3,  4],
      [5,  6,  7,  8,  9],
      [10, 11, 12, 13, 14],
      [15, 16, 17, 18, 19],
      [20, 21, 22, 23, 24]
    ])

    assert numbers == %{
      0 => {0, 0},
      1 => {0, 1},
      2 => {0, 2},
      3 => {0, 3},
      4 => {0, 4},
      5 => {1, 0},
      6 => {1, 1},
      7 => {1, 2},
      8 => {1, 3},
      9 => {1, 4},
      10 => {2, 0},
      11 => {2, 1},
      12 => {2, 2},
      13 => {2, 3},
      14 => {2, 4},
      15 => {3, 0},
      16 => {3, 1},
      17 => {3, 2},
      18 => {3, 3},
      19 => {3, 4},
      20 => {4, 0},
      21 => {4, 1},
      22 => {4, 2},
      23 => {4, 3},
      24 => {4, 4}
    }
  end

  test "day 04, part 1" do
    assert Day04.part1() == 1
  end

  test "day 04, part 2" do
    assert Day04.part2() == 2
  end
end
