defmodule Day06 do

  def find_start([one, two, three, four | rest], count) do
    uniq = MapSet.new([one, two, three, four]) |> MapSet.size()

    if uniq == 4 do
      count
    else
      find_start([two, three, four | rest], count + 1)
    end
  end

  def part1() do
    File.read!("input/input_06")
      |> String.split("", trim: true)
      |> find_start(4)
  end

  def part2() do

  end
end
