defmodule Day10 do
  def part1() do
    File.read!("input/input_10")
      |> String.split("\n", trim: true)
      |> Enum.map(fn line -> String.split(line, "", trim: true) end)
      |> IO.inspect()

    1
  end

  def part2() do
    2
  end
end
