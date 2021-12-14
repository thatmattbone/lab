defmodule Day07 do

  def parse_lines() do
    File.read!("input/input_07")
      |> String.split("\n", trim: true)
      |> hd()
      |> String.split(",", trim: true)
      |> Enum.map(&String.to_integer/1)
  end

  def part1() do
    IO.inspect(Day07.parse_lines())

    1
  end

  def part2() do
    2
  end
end
