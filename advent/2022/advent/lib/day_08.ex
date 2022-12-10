defmodule Day08 do

  def visible_left(grid, i, j) do
    true
  end

  def visible_right(grid, i, j) do
    true
  end

  def visible_down(grid, i, j) do
    true
  end

  def visible_up(grid, i, j) do
    true
  end

  def part1() do
    lines = File.read!("input/input_08")
      |> String.split("\n", trim: true)
      |> Enum.map(fn line ->
        String.split(line, "", trim: true)
          |> Enum.map(&String.to_integer/1)
        end)

    grid = Nx.tensor(lines, type: {:u, 8})


    outside_tree_count = 99 * 4 - 4

    visibles = for i <- 1..97 do
      for j <- 1..97 do
        #IO.inspect(grid[i][j])
        if visible_left(grid, i, j) or visible_right(grid, i, j) or visible_down(grid, i, j) or visible_up(grid, i, j) do
          1
        else
          0
        end
      end
    end

    visible_trees = visibles |> List.flatten() |> Enum.sum()

    IO.inspect(visible_trees + outside_tree_count)

    grid
  end

  def part2() do

  end

end
