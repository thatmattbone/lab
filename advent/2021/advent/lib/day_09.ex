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

  def part2() do
    2
  end

end
