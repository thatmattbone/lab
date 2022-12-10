defmodule Day08 do

  def visible(tensor, val) do
    Nx.reduce_max(tensor) < val
  end

  def visible_left(grid, i, j) do
    left_index = j - 1
    visible(grid[i: i][0..left_index], grid[i][j])
  end

  def visible_right(grid, i, j) do
    right_index = j + 1
    visible(grid[i: i][right_index..98], grid[i][j])
  end

  def visible_down(grid, i, j) do
    down_index = i + 1
    visible(grid[j: j][down_index..98], grid[i][j])
  end

  def visible_up(grid, i, j) do
    up_index = i - 1
    visible(grid[j: j][0..up_index], grid[i][j])
  end

  def part1() do
    lines = File.read!("input/input_08")
      |> String.split("\n", trim: true)
      |> Enum.map(fn line ->
        String.split(line, "", trim: true)
          |> Enum.map(&String.to_integer/1)
        end)

    grid = Nx.tensor(lines, names: [:i, :j], type: {:u, 8})

    outside_tree_count = 99 * 4 - 4

    visibles = for i <- 1..97 do
      for j <- 1..97 do
        if visible_left(grid, i, j) or visible_right(grid, i, j) or visible_down(grid, i, j) or visible_up(grid, i, j) do
          1
        else
          0
        end
      end
    end

    visible_tree_count = visibles |> List.flatten() |> Enum.sum()

    visible_tree_count + outside_tree_count
  end

  def part2() do

  end

end
