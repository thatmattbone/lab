defmodule Day03 do
  def part1() do
    File.read!("input/input_03")
      |> String.split("\n", trim: true)
      |> Enum.map(fn line ->
        half_len = String.length(line) / 2 |> trunc()
        [String.slice(line, 0, half_len), String.slice(line, half_len, half_len * 2)]
      end)
  end
end
