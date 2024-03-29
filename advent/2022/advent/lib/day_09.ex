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
    [{100, 100}] ++ move_list(moves, {100, 100})
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

  def next_tail_pos(_cur_pos={tx, ty}, _head_pos={hx, hy}) when tx == hx - 2 and ty == hy do
    # two to right
    {tx + 1, ty}
  end

  def next_tail_pos(_cur_pos={tx, ty}, _head_pos={hx, hy}) when tx == hx + 2 and ty == hy do
    # two to left
    {tx - 1, ty}
  end

  def next_tail_pos(_cur_pos={tx, ty}, _head_pos={hx, hy}) when tx == hx and ty == hy - 2 do
    # two up
    {tx, ty + 1}
  end

  def next_tail_pos(_cur_pos={tx, ty}, _head_pos={hx, hy}) when tx == hx and ty == hy + 2 do
    # two down
    {tx, ty - 1}
  end

  def next_tail_pos(_cur_pos={tx, ty}, _head_pos={hx, hy}) when tx == hx - 1 and ty == hy - 2 do
    # right one, up two
    {tx + 1, ty + 1}
  end

  def next_tail_pos(_cur_pos={tx, ty}, _head_pos={hx, hy}) when tx == hx + 1 and ty == hy - 2 do
    # left one, up two
    {tx - 1, ty + 1}
  end

  def next_tail_pos(_cur_pos={tx, ty}, _head_pos={hx, hy}) when tx == hx - 1 and ty == hy + 2 do
    # right one, down two
    {tx + 1, ty - 1}
  end

  def next_tail_pos(_cur_pos={tx, ty}, _head_pos={hx, hy}) when tx == hx + 1 and ty == hy + 2 do
    # left one, down two
    {tx - 1, ty - 1}
  end

  def next_tail_pos(_cur_pos={tx, ty}, _head_pos={hx, hy}) when tx == hx + 2 and ty == hy + 1 do
    # left two, down one
    {tx - 1, ty - 1}
  end

  def next_tail_pos(_cur_pos={tx, ty}, _head_pos={hx, hy}) when tx == hx - 2 and ty == hy + 1 do
    # right two, down one
    {tx + 1, ty - 1}
  end

  def next_tail_pos(_cur_pos={tx, ty}, _head_pos={hx, hy}) when tx == hx + 2 and ty == hy - 1 do
    # left two, up one
    {tx - 1, ty + 1}
  end

  def next_tail_pos(_cur_pos={tx, ty}, _head_pos={hx, hy}) when tx == hx - 2 and ty == hy - 1 do
    # right two, up one
    {tx + 1, ty + 1}
  end

  def next_tail_pos(_cur_pos={tx, ty}, _head_pos={hx, hy}) when tx == hx + 2 and ty == hy + 2 do
    # two below, two left
    {tx - 1, ty - 1}
  end

  def next_tail_pos(_cur_pos={tx, ty}, _head_pos={hx, hy}) when tx == hx - 2 and ty == hy + 2 do
    # two below, two right
    {tx + 1, ty - 1}
  end

  def next_tail_pos(_cur_pos={tx, ty}, _head_pos={hx, hy}) when tx == hx - 2 and ty == hy - 2 do
    # two above, two right
    {tx + 1, ty + 1}
  end

  def next_tail_pos(_cur_pos={tx, ty}, _head_pos={hx, hy}) when tx == hx + 2 and ty == hy - 2 do
    # two above, two left
    {tx - 1, ty + 1}
  end

  def tail_list([], _tail_pos) do
    []
  end

  def tail_list([head_pos={_hx, _hy} | rest], tail_pos={_tx, _ty}) do
    #IO.inspect(head_pos, label: "head")
    #IO.inspect(tail_pos, label: "tail")

    n = next_tail_pos(tail_pos, head_pos)
    [n | tail_list(rest, n)]
  end

  def part1() do
    moves = File.read!("input/input_09")
      |> String.split("\n", trim: true)
      |> Enum.map(fn line ->
        [d, magnitude] = String.split(line, " ")
        {parse_direction(d), String.to_integer(magnitude)}
      end)

    head_move_list = move_list(moves) # |> IO.inspect(limit: :infinity)

    tail_move_list = tail_list(head_move_list, {100, 100})

    MapSet.new(tail_move_list) |> MapSet.size()
  end


  def part2() do
    moves = File.read!("input/input_09")
      |> String.split("\n", trim: true)
      |> Enum.map(fn line ->
        [d, magnitude] = String.split(line, " ")
        {parse_direction(d), String.to_integer(magnitude)}
      end)

    head_move_list = move_list(moves) # |> IO.inspect(limit: :infinity)

    one_move_list = tail_list(head_move_list, {100, 100})
    two_move_list = tail_list(one_move_list, {100, 100})
    three_move_list = tail_list(two_move_list, {100, 100})
    four_move_list = tail_list(three_move_list, {100, 100})
    five_move_list = tail_list(four_move_list, {100, 100})
    six_move_list = tail_list(five_move_list, {100, 100})
    seven_move_list = tail_list(six_move_list, {100, 100})
    eight_move_list = tail_list(seven_move_list, {100, 100})
    nine_move_list = tail_list(eight_move_list, {100, 100})

    MapSet.new(nine_move_list) |> MapSet.size()
  end
end
