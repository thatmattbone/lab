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

    lines = Enum.filter(lines, fn {{x1, y1}, {x2, y2}} ->
      x1 == x2 or y1 == y2
    end)

    xs = Enum.flat_map(lines, fn {{x1, _y1}, {x2, _y2}} -> [x1, x2] end)
    max_x = Enum.max(xs)

    ys = Enum.flat_map(lines, fn {{_x1, y1}, {_x2, y2}} -> [y1, y2] end)
    max_y = Enum.max(ys)

    IO.inspect(max_x)
    IO.inspect(max_y)

    1
  end

  def part2() do
    2
  end
end
