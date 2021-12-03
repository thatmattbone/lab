defmodule Day02 do

  def part1() do
    body = File.read!("input/input_02")
    split_body = String.split(body, "\n")
    instructions_and_magnitudes = for i <- split_body, String.length(i) > 0 do
      [instruction, magnitude] = String.split(i, " ")
      {instruction, String.to_integer(magnitude)}
    end

    IO.inspect(instructions_and_magnitudes)
    1
  end

  def part2() do
    2
  end
end
