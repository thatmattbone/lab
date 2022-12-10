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

  def next_tail_pos(_cur_pos={tx, ty}, _head_pos={hx, hy}) when tx == hx and ty == hy do
    # overlap
    {tx, ty}
  end

  def next_tail_pos(_cur_pos={tx, ty}, _head_pos={hx, hy}) when tx == hx + 1 and ty == hy do
    # one to right
    {tx, ty}
  end

  def next_tail_pos(_cur_pos={tx, ty}, _head_pos={hx, hy}) when tx == hx - 1 and ty == hy do
    # one to left
    {tx, ty}
  end

  def next_tail_pos(_cur_pos={tx, ty}, _head_pos={hx, hy}) when tx == hx and ty == hy - 1 do
    # one down
    {tx, ty}
  end

  def next_tail_pos(_cur_pos={tx, ty}, _head_pos={hx, hy}) when tx == hx and ty == hy + 1 do
    # one up
    {tx, ty}
  end

  def next_tail_pos(_cur_pos={tx, ty}, _head_pos={hx, hy}) when tx == hx + 1 and ty == hy + 1 do
    # upper right
    {tx, ty}
  end

  def next_tail_pos(_cur_pos={tx, ty}, _head_pos={hx, hy}) when tx == hx - 1 and ty == hy + 1 do
    # upper left
    {tx, ty}
  end

  def next_tail_pos(_cur_pos={tx, ty}, _head_pos={hx, hy}) when tx == hx + 1 and ty == hy - 1 do
    # lower right
    {tx, ty}
  end

  def next_tail_pos(_cur_pos={tx, ty}, _head_pos={hx, hy}) when tx == hx - 1 and ty == hy - 1 do
    # lower left
    {tx, ty}
  end

  def next_tail_pos(_cur_pos={tx, ty}, _head_pos={hx, hy}) when tx == hx + 2 and ty == hy do
    # two to right
    {tx + 1, ty}
  end

  def next_tail_pos(_cur_pos={tx, ty}, _head_pos={hx, hy}) when tx == hx - 2 and ty == hy do
    # two to left
    {tx - 1, ty}
  end

  def next_tail_pos(_cur_pos={tx, ty}, _head_pos={hx, hy}) when tx == hx and ty == hy + 2 do
    # two up
    {tx, ty + 1}
  end

  def next_tail_pos(_cur_pos={tx, ty}, _head_pos={hx, hy}) when tx == hx and ty == hy - 2 do
    # two down
    {tx, ty - 1}
  end

  def next_tail_pos(_cur_pos={tx, ty}, _head_pos={hx, hy}) when tx == hx + 1 and ty == hy + 2 do
    # right one, up two
    {tx + 1, ty + 1}
  end

  def next_tail_pos(_cur_pos={tx, ty}, _head_pos={hx, hy}) when tx == hx - 1 and ty == hy + 2 do
    # left one, up two
    {tx - 1, ty + 1}
  end

  def next_tail_pos(_cur_pos={tx, ty}, _head_pos={hx, hy}) when tx == hx + 1 and ty == hy - 2 do
    # right one, down two
    {tx + 1, ty - 1}
  end

  def next_tail_pos(_cur_pos={tx, ty}, _head_pos={hx, hy}) when tx == hx - 1 and ty == hy - 2 do
    # left one, down two
    {tx - 1, ty - 1}
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
