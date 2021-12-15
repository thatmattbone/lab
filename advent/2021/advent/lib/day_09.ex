defmodule Day09 do
  def part1() do

    lines = File.read!("input/input_09")
      |> String.split("\n", trim: true)
      |> Enum.map(fn line ->
          Enum.map(String.split(line, "", trim: true), fn char -> String.to_integer(char) end)
            |> List.to_tuple()
        end)
      |> List.to_tuple()
      |> IO.inspect()

    1
  end

  def part2() do
    2
  end

end
