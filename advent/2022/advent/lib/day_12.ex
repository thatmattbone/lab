defmodule Day12 do

  def letter_to_elevation_map() do
    lower = for i <- 1..26, do: {to_string([i + 96]), i}
    Map.new(lower)
  end

  def build_grid() do
    File.read!("input/input_12")
      |> String.split("\n", trim: true)
      |> Enum.map(fn line ->
           String.split(line, "", trim: true) |> Enum.with_index()
         end)
      |> Enum.with_index()
      |> Enum.map(fn {row, i} ->
          Enum.map(row, fn {item, j} ->
            {{i, j}, item}
          end)
         end)
      |> List.flatten()
      |> Map.new()
  end

  def find_start([{key, value} | _rest]) when value == "S" do
    key
  end

  def find_start([{_key, _value} | rest]) do
    find_start(rest)
  end

  def find_start(grid) do
    find_start(Map.to_list(grid))
  end

  def find_end([{key, value} | _rest]) when value == "E" do
    key
  end

  def find_end([{_key, _value} | rest]) do
    find_end(rest)
  end

  def find_end(grid) do
    find_end(Map.to_list(grid))
  end

  def build_nodes(grid) do

  end

  def part1() do
    grid = build_grid()

    build_nodes(grid)
  end

  def part2() do

  end
end
