defmodule Day02Test do
  use ExUnit.Case

  test "day 02, part 1, example" do
    assert Day02.part1_example() == 15
  end

  test "day 02, part 1" do
    assert Day02.part1() == 12679
  end

  test "day 02, part 2, example" do
    assert Day02.part1_example() == 12
  end

  test "day 02, part 2" do
    assert Day02.part2() == 14470
  end
end
