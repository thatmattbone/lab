defmodule Day04Board do
  # stolen from jose valim's twitch stream
  # I followed along to learn some elixir
  empty_grid = Tuple.duplicate(Tuple.duplicate(false, 5), 5)

  @enforce_keys [:numbers]
  defstruct [:numbers, grid: empty_grid]

  def new(grid) do
    numbers = for {line, row} <- Enum.with_index(grid),
        {value, column} <- Enum.with_index(line),
        into: %{} do
          {value, {row, column}}
        end
    %Day04Board{numbers: numbers}
  end

  defp is_col_winner?(grid) do
    Enum.any?(0..4, fn col ->
      Enum.all?(0..4, fn row ->
        grid |> elem(row) |> elem(col)
      end)
    end)
  end

  def is_row_winner?(grid) do
    Enum.any?(0..4, fn row ->
      elem(grid, row) == {true, true, true, true, true}
    end)
  end

  def is_winner?(%Day04Board{grid: grid}) do
    is_row_winner?(grid) or is_col_winner?(grid)
  end

  def mark_space(%Day04Board{numbers: numbers} = board, number) do
    case numbers do
      %{^number => {row, column}} ->
        put_in(board, [Access.key(:grid), Access.elem(row), Access.elem(column)], true)

      %{} ->
        board
    end
  end

end
