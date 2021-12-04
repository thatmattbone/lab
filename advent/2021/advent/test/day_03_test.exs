defmodule Day03Test do
  use ExUnit.Case
  doctest Day03

  test "get_initial_map()" do
    assert map_size(Day03.get_initial_map()) == 12
  end

  test "int_to_bin()" do
    assert Day03.int_to_bin(hd(to_charlist("0"))) == 0
    assert Day03.int_to_bin(hd(to_charlist("1"))) == 1
  end

  test "input_str_to_index_counts" do
    assert Day03.input_str_to_index_counts("000110000001") == [
      {0, 0},
      {1, 0},
      {2, 0},
      {3, 1},
      {4, 1},
      {5, 0},
      {6, 0},
      {7, 0},
      {8, 0},
      {9, 0},
      {10, 0},
      {11, 1}
    ]
  end

  test "Day 03, part 1" do
    assert Day03.part1() == 1
  end


  test "Day 03, part 2" do
    assert Day03.part2() == 2
  end
end
