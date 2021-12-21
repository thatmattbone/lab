defmodule Day12Test do
  use ExUnit.Case
  doctest Day12

  test "is_big_cave?" do
    assert Day12.is_big_cave?("AB") == true
    assert Day12.is_big_cave?("ab") == false
    assert Day12.is_big_cave?("A") == true
    assert Day12.is_big_cave?("b") == false
  end

  test "test next paths" do
    next_paths = Day12.next_paths([{"ab", "de"}, {"ab", "fg"}, {"hi", "jk"}], "ab")

    assert next_paths == ["de", "fg"]
  end

  test "day 12, part 1" do
    assert Day12.part1() == 1
  end

  test "day 12, part 2" do
    assert Day12.part2() == 2
  end
end
