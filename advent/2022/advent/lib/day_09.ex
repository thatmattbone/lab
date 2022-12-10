defmodule Day09 do

  def parse_direction(d) when d == "U", do: :up
  def parse_direction(d) when d == "D", do: :down
  def parse_direction(d) when d == "R", do: :right
  def parse_direction(d) when d == "L", do: :left

  def move_list({:up, magnitude}, {x, y}) do
    for i <- 1..magnitude, do: {x + i, y}
  end

  def move_list({:down, magnitude}, {x, y}) do
    for i <- 1..magnitude, do: {x - i, y}
  end

  def move_list({:right, magnitude}, {x, y}) do
    for i <- 1..magnitude, do: {x, y + i}
  end

  def move_list({:left, magnitude}, {x, y}) do
    for i <- 1..magnitude, do: {x, y - i}
  end

  def move_list([], {_x, _y}) do
    []
  end

  def move_list([move | rest], {x, y}) do
    next_moves = move_list(move, {x, y})
    new_coords = List.last(next_moves)

    next_moves ++ move_list(rest, new_coords)
  end

  def move_list(moves) do
    [{0, 0}] ++ move_list(moves, {0, 0})
  end

  def part1() do
    moves = File.read!("input/input_09")
      |> String.split("\n", trim: true)
      |> Enum.map(fn line ->
        [d, magnitude] = String.split(line, " ")
        {parse_direction(d), String.to_integer(magnitude)}
      end)

    moves |>
      move_list()
  end


  def part2() do

  end
end
