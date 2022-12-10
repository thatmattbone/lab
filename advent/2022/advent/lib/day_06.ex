defmodule Day06 do

  def find_start([one, two, three, four | rest], count) do
    uniq = MapSet.new([one, two, three, four]) |> MapSet.size()

    if uniq == 4 do
      count
    else
      find_start([two, three, four | rest], count + 1)
    end
  end

  def find_start_14(input, count) do
    uniq = MapSet.new(Enum.take(input, 14)) |> MapSet.size()

    if uniq == 14 do
      count
    else
      [_first | rest] = input
      find_start_14(rest, count + 1)
    end
  end

  def part1() do
    File.read!("input/input_06")
      |> String.split("", trim: true)
      |> find_start(4)
  end

  def part2() do
    File.read!("input/input_06")
      |> String.split("", trim: true)
      |> find_start_14(14)
  end
end
