defmodule Day11 do
  def parse_grid() do
    grid = File.read!("input/input_11")
      |> String.split("\n", trim: true)
      |> Enum.map(fn line ->
          Enum.map(String.split(line, "", trim: true), fn char -> String.to_integer(char) end)
            |> List.to_tuple()
        end)
      |> List.to_tuple()
      |> IO.inspect()

    map = for x <- 0..9,
              y <- 0..9,
              into: %{} do
                {{x, y}, grid |> elem(y) |> elem(x)}
              end

    map
  end

  def part1() do
    IO.inspect(parse_grid(), limit: :infinity)
    1
  end

  def part2() do
    2
  end

end
