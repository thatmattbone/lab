defmodule Day04Test do
  use ExUnit.Case
  doctest Day04
  doctest Day04Board

  test "create new board from grid" do
    %Day04Board{numbers: numbers} = Day04Board.new(Enum.chunk_every(0..24, 5))

    assert numbers == %{
      0 => {0, 0},
      1 => {0, 1},
      2 => {0, 2},
      3 => {0, 3},
      4 => {0, 4},
      5 => {1, 0},
      6 => {1, 1},
      7 => {1, 2},
      8 => {1, 3},
      9 => {1, 4},
      10 => {2, 0},
      11 => {2, 1},
      12 => {2, 2},
      13 => {2, 3},
      14 => {2, 4},
      15 => {3, 0},
      16 => {3, 1},
      17 => {3, 2},
      18 => {3, 3},
      19 => {3, 4},
      20 => {4, 0},
      21 => {4, 1},
      22 => {4, 2},
      23 => {4, 3},
      24 => {4, 4}
    }
  end

  test "mark board" do
    board = Day04Board.new(Enum.chunk_every(0..24, 5))
    %Day04Board{grid: grid} = Day04Board.mark_space(board, 0)

    assert elem(grid, 0) |> elem(0) == true
    assert elem(grid, 0) |> elem(1) ==  false

    %Day04Board{grid: grid} = Day04Board.mark_space(board, 22)
    assert elem(grid, 4) |> elem(2) == true
  end

  test "is column winner" do
    board = Day04Board.new(Enum.chunk_every(0..24, 5))
      |> Day04Board.mark_space(0)
      |> Day04Board.mark_space(5)
      |> Day04Board.mark_space(10)
      |> Day04Board.mark_space(15)
      |> Day04Board.mark_space(20)

    assert Day04Board.is_winner?(board) == true
  end

  test "is row winner" do
    board = Day04Board.new(Enum.chunk_every(0..24, 5))
      |> Day04Board.mark_space(0)
      |> Day04Board.mark_space(1)
      |> Day04Board.mark_space(2)
      |> Day04Board.mark_space(3)
      |> Day04Board.mark_space(4)

    assert Day04Board.is_winner?(board) == true
  end

  test "day 04, part 1" do
    assert Day04.part1() == 31424
  end

  test "day 04, part 2" do
    assert Day04.part2() == 23042
  end
end
