defmodule Day01 do
  def count_of_increasing_items([head|tail], prev, increasing_count) when prev == -1 do
    count_of_increasing_items(tail, head, increasing_count)
  end

  def count_of_increasing_items([head|tail], prev, increasing_count) do
    if head > prev do
      count_of_increasing_items(tail, head, increasing_count + 1)
    else
      count_of_increasing_items(tail, head, increasing_count)
    end
  end

  def count_of_increasing_items([], _prev, increasing_count) do
    increasing_count
  end

  def part1() do
      body = File.read!("input/input_01")
      split_body = String.split(body, "\n")
      input_list = for i <- split_body, String.length(i) > 0, do: String.to_integer(i)

      count_of_increasing_items(input_list, -1, 0)
  end

  def sliding_window([one, two, three]) do
    [one + two + three]
  end

  def sliding_window([one, two, three | tail]) do
    [one + two + three] ++ sliding_window([two, three] ++ tail)  # could make this tail recursive with an accumulator
  end

  def part2() do
      body = File.read!("input/input_01")
      split_body = String.split(body, "\n")
      input_list = for i <- split_body, String.length(i) > 0, do: String.to_integer(i)

      count_of_increasing_items(sliding_window(input_list), -1, 0)
  end
end
