defmodule Day06Test do
  use ExUnit.Case
  doctest Day06

  test "evolve_list" do
    evolved = Day06.evolve_list_slow([3,4,3,1,2], 18)
    assert length(evolved) == 26
    assert evolved == [6,0,6,4,5,6,0,1,1,2,6,0,1,1,1,2,2,3,3,4,6,7,8,8,8,8]
  end

  test "day 06, part 1" do
    assert Day06.part1() == 395627
  end

  test "day 06, part 2" do
    assert Day06.part2() == 2
  end
end
