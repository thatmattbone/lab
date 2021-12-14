defmodule Day07 do

  def parse_lines() do
    File.read!("input/input_07")
      |> String.split("\n", trim: true)
      |> hd()
      |> String.split(",", trim: true)
      |> Enum.map(&String.to_integer/1)
  end

  def part1() do
    lines = Day07.parse_lines()

    min_position = Enum.min(lines)
    max_position = Enum.max(lines)

    IO.inspect(min_position)
    IO.inspect(max_position)

    distances = Enum.map(min_position..max_position, fn x ->
      distance = Enum.sum(Enum.map(lines, fn y ->
        abs(x - y)
      end))
      {x, distance}
    end)

    {_i, fuel} = Enum.min_by(distances, fn {_i, distance} -> distance end)

    fuel
  end

  def part2() do
    2
  end
end
