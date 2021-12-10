defmodule Day05Test do
  use ExUnit.Case
  doctest Day05

  test "get_spaces_to_mark_with_diagonals" do
    assert Day05.get_spaces_to_mark_with_diagonals({{1, 1}, {3, 3}}) == [{1, 1}, {2, 2}, {3, 3}]  # A
    assert Day05.get_spaces_to_mark_with_diagonals({{2, 1}, {5, 4}}) ==  [{2, 1}, {3, 2}, {4, 3}, {5, 4}] # A

    assert Day05.get_spaces_to_mark_with_diagonals({{0, 5}, {2, 3}}) ==  [{0,5}, {1, 4}, {2, 3}]  # B

    assert Day05.get_spaces_to_mark_with_diagonals({{5, 4}, {2, 1}}) ==  [{5, 4}, {4, 3}, {3, 2}, {2, 1}] # C

    assert Day05.get_spaces_to_mark_with_diagonals({{9, 7}, {7, 9}}) == [{9, 7}, {8, 8}, {7, 9}]  # D
  end

  test "day 05, part 1" do
    assert Day05.part1() == 6311
  end

  test "day 05, part 2" do
    assert Day05.part2() == 19929
  end

end
