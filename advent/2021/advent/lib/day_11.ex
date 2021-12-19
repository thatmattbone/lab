defmodule Day11 do
  def parse_input_to_grid_map() do
    grid = File.read!("input/input_11_test")
      |> String.split("\n", trim: true)
      |> Enum.map(fn line ->
          Enum.map(String.split(line, "", trim: true), fn char -> String.to_integer(char) end)
            |> List.to_tuple()
        end)
      |> List.to_tuple()

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
    neighbor_vals = [
      {x - 1, y - 1},
      {x - 1, y},
      {x - 1, y + 1},

      {x, y - 1},
      {x, y + 1},

      {x + 1, y - 1},
      {x + 1, y},
      {x + 1, y + 1},
    ]

    neighbor_vals = Enum.filter(neighbor_vals, fn {x, y} -> grid_map[{x, y}] != nil and grid_map[{x, y}] != 0 end)

    for {x, y} <- neighbor_vals, into: grid_map do
      {{x, y}, grid_map[{x, y}] + 1}
    end
  end

  def flash_octopii(grid_map, current_num_flashes) do
    num_octopuses_to_flash = Enum.filter(Map.to_list(grid_map), fn {_, val} -> val > 9 end)

    #IO.inspect(num_octopuses_to_flash)

    if length(num_octopuses_to_flash) > 0 do
        {spot_to_flash, _val} = hd(num_octopuses_to_flash)
        grid_map = bump_neighbors(grid_map, spot_to_flash)
        grid_map = Map.put(grid_map, spot_to_flash, 0)
        flash_octopii(grid_map, current_num_flashes + 1)
      else
        {grid_map, current_num_flashes}
    end

  end

  def evolve_one_step(grid_map) do
    grid_map = bump_grid_map(grid_map)

    #print_grid(grid_map)

    flash_octopii(grid_map, 0)
  end

  def evolve(_grid_map, num_steps, current_num_flashes) when num_steps == 0 do
    current_num_flashes
  end

  def evolve(grid_map, num_steps, current_num_flashes) do
    {grid_map, num_flashes} = evolve_one_step(grid_map)
    print_grid(grid_map)
    evolve(grid_map, num_steps - 1, current_num_flashes + num_flashes)
  end

  def print_grid(grid_map) do
    for y <- 0..10 do
      IO.puts("#{grid_map[{0, y}]}#{grid_map[{1, y}]}#{grid_map[{2, y}]}#{grid_map[{3, y}]}#{grid_map[{4, y}]}#{grid_map[{5, y}]}#{grid_map[{6, y}]}#{grid_map[{7, y}]}#{grid_map[{8, y}]}#{grid_map[{9, y}]}")
    end
  end

  def part1() do
    #IO.inspect(parse_input_to_grid_map(), limit: :infinity)
    grid_map = parse_input_to_grid_map()
    IO.puts("")
    print_grid(grid_map)
    evolve(grid_map, 100, 0)
  end

  @spec part2 :: 2
  def part2() do
    2
  end

end
