defmodule Day03 do

  def part1() do
    body = File.read!("input/input_03")
    split_body = for i <- String.split(body, "\n"), String.length(i) > 0, do: i

    # Enum.with_index(entry)
    foo = for entry <- split_body, {bit, i} <- Enum.with_index(Kernel.to_charlist(entry)) do
      {i, Kernel.to_string(bit)}
    end
    IO.inspect(foo)
    1
  end

  def part2() do
    2
  end

end
