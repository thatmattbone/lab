defmodule Day12Test do
  use ExUnit.Case
  doctest Day12

  test "is_big_cave?" do
    assert Day12.is_big_cave?("AB") == true
    assert Day12.is_big_cave?("ab") == false
    assert Day12.is_big_cave?("A") == true
    assert Day12.is_big_cave?("b") == false
  end

  test "next_paths" do
    next_paths = Day12.get_next_paths([{"ab", "de"}, {"ab", "fg"}, {"hi", "jk"}], "ab")

    assert next_paths == ["de", "fg"]
  end

  test "filter_next_paths" do
    assert Day12.filter_next_paths(["ab", "DE", "fg"], ["ab", "DE"]) == ["DE", "fg"]
  end

  test "day 12, part 1" do
    assert Day12.part1() == 4495
  end

  test "day 12, part 2" do
    assert Day12.part2() == 2
  end
end
