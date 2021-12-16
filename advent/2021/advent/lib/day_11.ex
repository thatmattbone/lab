defmodule Day11 do
  def parse_input_to_grid_map() do
    grid = File.read!("input/input_11")
      |> String.split("\n", trim: true)
      |> Enum.map(fn line ->
          Enum.map(String.split(line, "", trim: true), fn char -> String.to_integer(char) end)
            |> List.to_tuple()
        end)
      |> List.to_tuple()
      |> IO.inspect()

    grid_map = for x <- 0..9,
                   y <- 0..9,
                   into: %{} do
                    {{x, y}, grid |> elem(y) |> elem(x)}
                   end

    grid_map
  end

  def bump_grid_map(grid_map) do
    for {{x, y}, value} <- Map.to_list(grid_map), into: %{}, do: {{x, y}, value + 1}
  end

  def bump_neighbors(grid_map, {x, y}) do
    neighbor_vals = {
      {x - 1, y - 1},
      {x - 1, y},
      {x - 1, y + 1},

      {x, y - 1},
      {x, y + 1},

      {x + 1, y - 1},
      {x + 1, y},
      {x + 1, y + 1},
    }
  end

  def evolve_one_step(grid_map) do
    grid_map = bump_grid_map(grid_map)

    IO.inspect(grid_map)
  end

  def part1() do
    #IO.inspect(parse_input_to_grid_map(), limit: :infinity)
    1
  end

  def part2() do
    2
  end

end
