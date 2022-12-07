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


  def read_instructions() do
    File.read!("input/input_05")
      |> String.split("\n", trim: true)
      |> Enum.drop(9)
  end

  def part1() do

  end

end
