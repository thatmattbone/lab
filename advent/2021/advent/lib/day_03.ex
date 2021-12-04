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

  def input_str_to_index_counts(input_str) do
    for {bit, i} <- Enum.with_index(to_charlist(input_str)) do
      {i, int_to_bin(bit)}
    end
  end

  def add_counts([], counts_map) do
    counts_map
  end

  def add_counts([head | tail], counts_map) do
    {index, value} = head
    inner_map = Map.get(counts_map, index)
    inner_map = Map.update!(inner_map, value, & &1 + 1)

    counts_map = Map.replace(counts_map, index, inner_map)

    add_counts(tail, counts_map)
  end

  def sum_counts([], counts_map) do
    counts_map
  end

  def sum_counts([head | tail], counts_map) do
    counts_map = add_counts(head, counts_map)
    sum_counts(tail, counts_map)
  end

  def part1() do
    body = File.read!("input/input_03")
    split_body = for i <- String.split(body, "\n"), String.length(i) > 0, do: i
    by_index_counts = for i <- split_body, do: input_str_to_index_counts(i)

    #IO.inspect(by_index_counts)
    #IO.inspect(input_str_to_index_counts(hd(split_body)))
    #
    # Enum.with_index(entry)
    # foo = for entry <- split_body,
    #           {bit, i} <- Enum.with_index(Kernel.to_charlist(entry)), reduce %{} do
    #   acc -> map.update(acc, i, 1, {i, Kernel.to_string(bit)}
    # end

    # # require IEx; IEx.pry

    # IO.inspect(foo)

    counts_map = get_initial_map()

    counts_map = sum_counts(by_index_counts, counts_map)

    IO.inspect(counts_map)

    1
  end

  def part2() do
    2
  end

end
