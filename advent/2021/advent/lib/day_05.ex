defmodule Day05 do
  def part1() do
    lines = File.read!("input/input_05")
      |> String.split("\n", trim: true)
      |> Enum.map(fn line -> String.split(line, " -> ") end)
      |> Enum.map(fn [first, second] -> {String.split(first, ","), String.split(second, ",")} end)
      |> Enum.map(fn {[x1_str, y1_str], [x2_str, y2_str]} ->
         {
           {String.to_integer(x1_str), String.to_integer(y1_str)},
           {String.to_integer(x2_str), String.to_integer(y2_str)}
         }
        end)
    IO.inspect(lines)

    1
  end

  def part2() do
    2
  end
end
