defmodule Day01 do


  def count([head|tail], prev, increasing_count) when prev == -1 do
    count(tail, head, increasing_count)
  end

  def count([head|tail], prev, increasing_count) do
    if head > prev do
      count(tail, head, increasing_count + 1)
    else
      count(tail, head, increasing_count)
    end
  end

  def count([], _prev, increasing_count) do
    increasing_count
  end

  def part1() do
      body = File.read!("input/input_01")
      split_body = String.split(body, "\n")
      input_list = for i <- split_body, String.length(i) > 0, do: String.to_integer(i)

      count(input_list, -1, 0)
  end
end
