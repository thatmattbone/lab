defmodule Day05 do

  def get_max_xs(input) do
    xs = Enum.flat_map(input, fn {{x1, _y1}, {x2, _y2}} -> [x1, x2] end)
    Enum.max(xs)
  end

  def get_max_ys(input) do
    ys = Enum.flat_map(input, fn {{_x1, y1}, {_x2, y2}} -> [y1, y2] end)
    Enum.max(ys)
  end

  def build_grid() do
    for x <- 1..1000,
        y <- 1..1000,
        into: %{} do
          {{x, y}, 0}
        end
  end

  def get_spaces_to_mark({{x1, y1}, {x2, y2}}) when x1 == x2 do
    for i <- y1..y2, do: {x1, i}
  end

  def get_spaces_to_mark({{x1, y1}, {x2, y2}}) when y1 == y2 do
    for i <- x1..x2, do: {i, y1}
  end

  def part1() do
    lines = File.read!("input/input_05")
      |> String.split("\n", trim: true)
      |> Enum.map(fn line -> String.split(line, " -> ") end)
      |> Enum.map(fn [first, second] -> {String.split(first, ","), String.split(second, ",")} end)
      |> Enum.map(fn {[x1_str, y1_str], [x2_str, y2_str]} ->
         {
           {String.to_integer(x1_str), String.to_integer(y1_str)},
           {String.to_integer(x2_str), String.to_integer(y2_str)}
         }
        end)

    lines = Enum.filter(lines, fn {{x1, y1}, {x2, y2}} ->
      x1 == x2 or y1 == y2
    end)

    grid = Enum.reduce(lines, %{}, fn line, acc ->
      Enum.reduce(Day05.get_spaces_to_mark(line), acc, fn space, acc ->
        {_, new_map} = Map.get_and_update(acc, space, fn currval ->
          case currval do
            nil -> {currval, 1}
            _ -> {currval, currval + 1}
          end
        end)
        new_map
      end)
    end)

    grid = grid
      |> Map.to_list()
      |> Enum.filter(fn {{_x, _y}, count} -> count > 1 end)
      |> length()

    grid
  end

  def part2() do
    2
  end
end
