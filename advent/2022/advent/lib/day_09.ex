defmodule Day09 do

  def parse_direction(d) when d == "U", do: :up
  def parse_direction(d) when d == "D", do: :down
  def parse_direction(d) when d == "R", do: :right
  def parse_direction(d) when d == "L", do: :left

  def part1() do
    File.read!("input/input_09")
      |> String.split("\n", trim: true)
      |> Enum.map(fn line ->
        [d, magnitude] = String.split(line, " ")
        {parse_direction(d), String.to_integer(magnitude)}
      end)
  end


  def part2() do

  end
end
