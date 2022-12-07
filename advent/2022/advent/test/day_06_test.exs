defmodule Day06Test do
  use ExUnit.Case

  test "find_start()" do
    assert Day06.find_start(String.split("bvwbjplbgvbhsrlpgdmjqwftvncz", "", trim: true), 4) == 5
    assert Day06.find_start(String.split("nppdvjthqldpwncqszvftbrmjlhg", "", trim: true), 4) == 6
    assert Day06.find_start(String.split("nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg", "", trim: true), 4) == 10
    assert Day06.find_start(String.split("zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw", "", trim: true), 4) == 11
  end

  test "find_start_14()" do
    assert Day06.find_start_14(String.split("mjqjpqmgbljsphdztnvjfqwrcgsmlb", "", trim: true), 14) == 19
    assert Day06.find_start_14(String.split("bvwbjplbgvbhsrlpgdmjqwftvncz", "", trim: true), 14) == 23
    assert Day06.find_start_14(String.split("nppdvjthqldpwncqszvftbrmjlhg", "", trim: true), 14) == 23
    assert Day06.find_start_14(String.split("zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw", "", trim: true), 14) == 26
  end

  test "day 06, part1" do
    assert Day06.part1() == 1566
  end

  test "day 06, part2" do
    assert Day06.part2()
  end

end
