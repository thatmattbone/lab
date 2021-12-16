defmodule Day09 do

  def is_value_less?(value, values_list) do
    value < Enum.min(values_list)
  end

  def get_grid_val(grid, i, j) when i >= 0 and i <= 99 and j >= 0 and j <= 99 do
    grid |> elem(i) |> elem(j)
  end

  def get_grid_val(_grid, _i, _j) do
    10
  end

  def is_local_min?(grid, i, j) do
    value = grid |> elem(i) |> elem(j)

    values_list = [
      get_grid_val(grid, i - 1, j),
      get_grid_val(grid, i + 1, j),
      get_grid_val(grid, i, j - 1),
      get_grid_val(grid, i, j + 1),
    ]

    Day09.is_value_less?(value, values_list)
  end

  def part1() do
    grid = File.read!("input/input_09")
      |> String.split("\n", trim: true)
      |> Enum.map(fn line ->
          Enum.map(String.split(line, "", trim: true), fn char -> String.to_integer(char) end)
            |> List.to_tuple()
        end)
      |> List.to_tuple()

    mins = for i <- 0..99,
               j <- 0..99,
              Day09.is_local_min?(grid, i, j) do
                get_grid_val(grid, i, j) + 1
              end

    Enum.sum(mins)
  end

  def find_basin_map(grid, {i, j}) do
    value = Day09.get_grid_val(grid, i, j)

    values_list = [
      {get_grid_val(grid, i - 1, j), {i - 1, j}},
      {get_grid_val(grid, i + 1, j), {i + 1, j}},
      {get_grid_val(grid, i, j - 1), {i, j - 1}},
      {get_grid_val(grid, i, j + 1), {i, j + 1}}
    ]

    values_list = Enum.filter(values_list, fn {grid_value, {_i, _j}} ->
      grid_value > value and grid_value != 9 and grid_value != 10
    end)

    basin_map = %{{i, j} => value}

    Map.merge(basin_map,
              Enum.reduce(values_list, %{}, fn {_value, {i, j}}, acc ->
                Map.merge(acc, Day09.find_basin_map(grid, {i, j}))
              end))
  end

  def part2() do
    grid = File.read!("input/input_09")
      |> String.split("\n", trim: true)
      |> Enum.map(fn line ->
          Enum.map(String.split(line, "", trim: true), fn char -> String.to_integer(char) end)
            |> List.to_tuple()
        end)
      |> List.to_tuple()

    mins = for i <- 0..99,
               j <- 0..99,
              Day09.is_local_min?(grid, i, j) do
                {i, j}
              end

    basins = mins
      |> Enum.map(fn {i, j} ->
        find_basin_map(grid, {i, j})
      end)
      |> Enum.map(fn basin_map -> map_size(basin_map) end)
      |> Enum.sort()
      |> Enum.reverse()
      |> Enum.take(3)


    [one, two, three] = basins

    one * two * three
  end

end
