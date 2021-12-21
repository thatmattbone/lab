defmodule Day12 do

  def parse_input_to_map() do
    File.read!("input/input_12")
      |> String.split("\n", trim: true)
      |> Enum.map(fn line ->
          [start_elem, end_elem] = String.split(line, "-")
          {start_elem, end_elem}
        end)
  end

  def is_big_cave?(cave_name) do
    String.upcase(cave_name) == cave_name
  end

  def next_paths(paths, curr_elem) do
    paths
     |> Enum.filter(fn {src, _dest} ->
          src == curr_elem
        end)
     |> Enum.map(fn {_src, dest} ->
        dest
     end)
  end

  def part1() do
    input_map = parse_input_to_map()
    IO.inspect(input_map)
    1
  end

  def part2() do
    2
  end

end
