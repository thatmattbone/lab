defmodule Day08 do

  def part1() do

    lines = File.read!("input/input_08")
      |> String.split("\n", trim: true)
      |> Enum.map(fn line ->
        [input, output] = String.split(line, "|", trim: true)
        {String.split(input, " ", trim: true), String.split(output, " ", trim: true)}
      end)

    counts = Enum.flat_map(lines, fn {_input, output} ->
      Enum.map(output, fn x ->
        x_len = String.length(x)

        case x_len do
          2 -> 1
          3 -> 1
          4 -> 1
          7 -> 1
          _ -> 0
        end
      end)
    end)

    Enum.sum(counts)
  end

  def part2() do
    2
  end

end
