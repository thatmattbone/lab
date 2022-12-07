defmodule Day06Test do
  use ExUnit.Case

  test "find_start()" do
    Day06.find_start(String.split("bvwbjplbgvbhsrlpgdmjqwftvncz", "", trim: true), 4) == 5
    Day06.find_start(String.split("nppdvjthqldpwncqszvftbrmjlhg", "", trim: true), 4) == 6
    Day06.find_start(String.split("nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg", "", trim: true), 4) == 10
    Day06.find_start(String.split("zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw", "", trim: true), 4) == 11
  end


  test "day 06, part1" do
    Day06.part1() == 1566
  end

  test "day 06, part2" do

  end

end
