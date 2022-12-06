defmodule Day03 do


  # Lowercase item types a through z have priorities 1 through 26.
  # Uppercase item types A through Z have priorities 27 through 52.

  def priority(input_str) do

  end

  def add_to_count_map(count_map, str) do
    Map.update(count_map, str, [str], fn existing_list -> existing_list ++ [str] end)
  end

  def str_to_count_map(input_str) do
    String.split(input_str, "", trim: true)
      |> Enum.reduce(%{}, fn i, count_map -> add_to_count_map(count_map, i) end)
  end

  def part1() do
    File.read!("input/input_03")
      |> String.split("\n", trim: true)
      |> Enum.map(fn line ->
        half_len = String.length(line) / 2 |> trunc()
        [String.slice(line, 0, half_len), String.slice(line, half_len, half_len * 2)]
      end)
  end
end
