defmodule Day05 do

  def read_starting_stack() do
    File.read!("input/input_05")
      |> String.split("\n", trim: true)
      |> Enum.slice(0, 9)
  end

  def starting_stack() do
    # this is hardcoded for now
    %{
      1 => String.split("NWFRZSMD", "", trim: true),
      2 => String.split("SGQPW", "", trim: true),
      3 => String.split("CJNFQVRW", "", trim: true),
      4 => String.split("LDGCPZF", "", trim: true),
      5 => String.split("SPT", "", trim: true),
      6 => String.split("LRWFDH", "", trim: true),
      7 => String.split("CDNZ", "", trim: true),
      8 => String.split("QJSVFRNW", "", trim: true),
      9 => String.split("VWZGSMR", "", trim: true),
    }
  end

  def move(stack, from, to) do
    [top | rest] = Map.get(stack, from)
    new_stack = [top | Map.get(stack, to)]

    stack
      |> Map.put(from, rest)
      |> Map.put(to, new_stack)
  end

  def move(stack, _from, _to, count) when count == 0 do
    stack
  end

  def move(stack, from, to, count) do
    move(move(stack, from, to), from, to, count - 1)
  end

  def move_and_retain(stack, from, to, count) do
    from_stack = Map.get(stack, from)

    boxes_moved = Enum.slice(from_stack, 0, count)

    new_from_stack = Enum.drop(from_stack, count)

    new_to_stack = boxes_moved ++ Map.get(stack, to)

    stack
      |> Map.put(from, new_from_stack)
      |> Map.put(to, new_to_stack)
  end

  def read_instructions() do
    File.read!("input/input_05")
      |> String.split("\n", trim: true)
      |> Enum.drop(9)
  end

  def parse_instructions() do
    read_instructions()
      |> Enum.map(fn line ->
        [_, count, _, from, _, to] = String.split(line, " ", trim: true)
        {String.to_integer(count), String.to_integer(from), String.to_integer(to)}
      end)
  end

  def top_of_stack(final_stack) do
    Enum.map(1..9, fn x ->
      [head | _rest] = Map.get(final_stack, x)
      head
    end) |> Enum.join("")
  end

  def part1() do
    parse_instructions()
      |> Enum.reduce(starting_stack(), fn {count, from, to}, stack -> move(stack, from, to, count) end)
      |> top_of_stack()
  end

  def part2() do
    parse_instructions()
      |> Enum.reduce(starting_stack(), fn {count, from, to}, stack -> move_and_retain(stack, from, to, count) end)
      |> top_of_stack()
  end

end
