defmodule Day03 do

  def get_initial_map() do
    %{
      0 => %{0 => 0, 1 => 0},
      1 => %{0 => 0, 1 => 0},
      2 => %{0 => 0, 1 => 0},
      3 => %{0 => 0, 1 => 0},
      4 => %{0 => 0, 1 => 0},
      5 => %{0 => 0, 1 => 0},
      6 => %{0 => 0, 1 => 0},
      7 => %{0 => 0, 1 => 0},
      8 => %{0 => 0, 1 => 0},
      9 => %{0 => 0, 1 => 0},
      10 => %{0 => 0, 1 => 0},
      11 => %{0 => 0, 1 => 0},
    }
  end

  def int_to_bin(val) when val == 48, do: 0
  def int_to_bin(val) when val == 49, do: 1

  def input_str_to_list(input_str) do
    for {bit, i} <- Enum.with_index(to_charlist(input_str)) do
      {i, int_to_bin(bit)}
    end
  end

  def part1() do
    body = File.read!("input/input_03")
    split_body = for i <- String.split(body, "\n"), String.length(i) > 0, do: i

    IO.inspect(hd(split_body))
    IO.inspect(input_str_to_list(hd(split_body)))

    # Enum.with_index(entry)
    # foo = for entry <- split_body,
    #           {bit, i} <- Enum.with_index(Kernel.to_charlist(entry)), reduce %{} do
    #   acc -> map.update(acc, i, 1, {i, Kernel.to_string(bit)}
    # end

    # # require IEx; IEx.pry

    # IO.inspect(foo)
    1
  end

  def part2() do
    2
  end

end
