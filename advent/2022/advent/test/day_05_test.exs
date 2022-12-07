defmodule Day05Test do
  use ExUnit.Case

  test "move" do
    start_map = %{
      1 => ["A", "B"],
      2 => ["C"],
      3 => ["D", "E"],
    }

    next_map = Day05.move(start_map, 1, 3)
    assert next_map == %{
      1 => ["B"],
      2 => ["C"],
      3 => ["A", "D", "E"],
    }

    third_map = Day05.move(next_map, 1, 3)
    assert third_map == %{
      1 => [],
      2 => ["C"],
      3 => ["B", "A", "D", "E"],
    }
  end

  test "multiple moves" do
    start_map = %{
      1 => ["A", "B"],
      2 => ["C"],
      3 => ["D", "E"],
    }

    next_map = Day05.move(start_map, 1, 3, 2)
    assert next_map == %{
      1 => [],
      2 => ["C"],
      3 => ["B", "A", "D", "E"],
    }
  end

  test "day 05, part 1" do
    assert Day05.part1() == "FWNSHLDNZ"
  end

end
