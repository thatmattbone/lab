defmodule Day08 do
  # import Nx.Defn  # TODO try this out with defn? idk?

  def view_left(grid, i, j) do
    left_index = j - 1
    grid[i: i][0..left_index]
  end

  def view_right(grid, i, j) do
    bound = Nx.axis_size(grid, 0) - 1
    right_index = j + 1
    grid[i: i][right_index..bound]
  end

  def view_down(grid, i, j) do
    bound = Nx.axis_size(grid, 0) - 1
    down_index = i + 1
    grid[j: j][down_index..bound]
  end

  def view_up(grid, i, j) do
    up_index = i - 1
    grid[j: j][0..up_index]
  end

  def visible(tensor, val) do
    Nx.reduce_max(tensor) < val
  end

  def visible_left(grid, i, j) do
    visible(view_left(grid, i, j), grid[i][j])
  end

  def visible_right(grid, i, j) do
    visible(view_right(grid, i, j), grid[i][j])
  end

  def visible_down(grid, i, j) do
    visible(view_down(grid, i, j), grid[i][j])
  end

  def visible_up(grid, i, j) do
    visible(view_up(grid, i, j), grid[i][j])
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

  def view_to_score([], _item, count) do
    count
  end

  def view_to_score([first | _rest], item, count) when item == first do
    count
  end

  def view_to_score([first | rest], item, count) when item > first do
    view_to_score(rest, item, count + 1)
  end

  def view_to_score([first | _rest], item, count) when item < first do
    count
  end

  def scenic_score(grid, i, j) do
    # looking left and up need the lists reversed
    [value] = Nx.to_flat_list(grid[i][j])

    left_score = Nx.to_flat_list(view_left(grid, i, j)) |> Enum.reverse() |> IO.inspect(label: "left") |> view_to_score(value, 1)
    up_score = Nx.to_flat_list(view_up(grid, i, j)) |> Enum.reverse() |> IO.inspect(label: "up")|> view_to_score(value, 1)
    right_score = Nx.to_flat_list(view_right(grid, i, j)) |> IO.inspect(label: "right") |> view_to_score(value, 1)
    down_score = Nx.to_flat_list(view_down(grid, i, j)) |> IO.inspect(label: "down") |> view_to_score(value, 1)

    left_score * up_score * right_score * down_score
  end

  def part2() do
    lines = File.read!("input/input_08")
      |> String.split("\n", trim: true)
      |> Enum.map(fn line ->
        String.split(line, "", trim: true)
          |> Enum.map(&String.to_integer/1)
        end)

    grid = Nx.tensor(lines, names: [:i, :j], type: {:u, 8})

    scenic_scores = for i <- 1..97 do
      for j <- 1..97 do
        scenic_score(grid, i, j)
      end
    end

    scenic_scores
      |> List.flatten()
      |> IO.inspect()
      |> Enum.max()
  end

  def part2example1() do
    ex1 = Nx.tensor([
      [3, 0, 3, 7, 3],
      [2, 5, 5, 1, 2],
      [6, 5, 3, 3, 2],
      [3, 3, 5, 4, 9],
      [3, 5, 3, 9, 0],
    ], names: [:i, :j], type: {:u, 8})

    scenic_score(ex1, 1, 2)
  end

end
