defmodule Day04 do


  def part1() do
    calls = File.read!("input/input_04_calls")
      |> String.split(",")
      |> Enum.map(&String.to_integer/1)

    list_of_grids = File.read!("input/input_04_tables")
      |> String.split("\n", trim: true)
      |> Enum.chunk_every(5)
      |> Enum.map(fn table_rows ->
          Enum.map(table_rows, fn table_row ->
            table_row |> String.split(" ", trim: true) |> Enum.map(&String.to_integer/1)
          end)
      end)

    boards = for grid <- list_of_grids do
      Day04Board.new(grid)
    end

    {number, board = %Day04Board{}} =
      Enum.reduce_while(calls, boards, fn number_called, boards ->
        boards = Enum.map(boards, &Day04Board.mark_space(&1, number_called))

        if board = Enum.find(boards, &Day04Board.is_winner?/1) do
          {:halt, {number_called, board}}
        else
          {:cont, boards}
        end
      end)

    number * Day04Board.unmarked_sum(board)
  end

  def part2() do
    calls = File.read!("input/input_04_calls")
      |> String.split(",")
      |> Enum.map(&String.to_integer/1)

    list_of_grids = File.read!("input/input_04_tables")
      |> String.split("\n", trim: true)
      |> Enum.chunk_every(5)
      |> Enum.map(fn table_rows ->
          Enum.map(table_rows, fn table_row ->
            table_row |> String.split(" ", trim: true) |> Enum.map(&String.to_integer/1)
          end)
      end)

    boards = for grid <- list_of_grids do
      Day04Board.new(grid)
    end

    {number_called, last_winner = %Day04Board{}} =
      Enum.reduce_while(calls, boards, fn number_called, boards ->
        boards = Enum.map(boards, &Day04Board.mark_space(&1, number_called))

        losers = Enum.filter(boards, fn board -> not Day04Board.is_winner?(board) end)

        case losers do
          [] ->
            [board] = boards
            {:halt, {number_called, board}}

          losers ->
            {:cont, losers}
        end
      end)

      number_called * Day04Board.unmarked_sum(last_winner)
  end
end
