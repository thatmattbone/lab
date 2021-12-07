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

    [first_board | _] = boards
    IO.inspect(first_board)

    1
  end

  def part2() do
    2
  end
end
