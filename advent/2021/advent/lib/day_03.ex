defmodule Day03 do

  def read_input() do
    body = File.read!("input/input_03")
    String.split(body, "\n", trim: true)
  end

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

  def max_summed_counts_to_list([]), do: []

  def max_summed_counts_to_list([{_key, value} | tail]) do
    if Map.get(value, 0) > Map.get(value, 1) do
        [0] ++ max_summed_counts_to_list(tail)
      else
        [1] ++ max_summed_counts_to_list(tail)
    end
  end

  def min_summed_counts_to_list([]), do: []

  def min_summed_counts_to_list([{_key, value} | tail]) do
    if Map.get(value, 0) > Map.get(value, 1) do
        [1] ++ min_summed_counts_to_list(tail)
      else
        [0] ++ min_summed_counts_to_list(tail)
    end
  end

  def part1() do
    input_list = read_input()

    by_index_counts = for i <- input_list, do: input_str_to_index_counts(i)

    counts_map = sum_counts(by_index_counts, get_initial_map())

    sort_func = fn {key, _value} -> key end
    sorted_counts_map_values = Enum.sort_by(Map.to_list(counts_map), &(sort_func.(&1)))

    final_gamma_rate_list = max_summed_counts_to_list(sorted_counts_map_values)
    final_epsilon_rate_list = min_summed_counts_to_list(sorted_counts_map_values)

    gamma_rate = String.to_integer(Enum.join(final_gamma_rate_list), 2)
    epsilon_rate = String.to_integer(Enum.join(final_epsilon_rate_list), 2)

    gamma_rate * epsilon_rate
  end

  def filter_for_list_most_common(bin_lists, pos) do  # oxygen rating, value is 1 if equally common
    bin_lists_with_counts = for list_of_ints <- bin_lists do
      for {bit, i} <- Enum.with_index(list_of_ints) do
        {i, bit}
      end
    end
    counts_map = sum_counts(bin_lists_with_counts, get_initial_map())

    %{0 => zero_count, 1 => one_count} = Map.get(counts_map, pos)

    value = if zero_count > one_count do
      0
    else
      1
    end

    filtered = for i <- bin_lists, Enum.at(i, pos) == value, do: i

    if length(filtered) == 1 do
      filtered
    else
      filter_for_list_most_common(filtered, pos + 1)
    end
  end

  def filter_for_list_least_common(bin_lists, pos) do  # co2 rating, value is 0 if equally common
    bin_lists_with_counts = for list_of_ints <- bin_lists do
      for {bit, i} <- Enum.with_index(list_of_ints) do
        {i, bit}
      end
    end
    counts_map = sum_counts(bin_lists_with_counts, get_initial_map())

    %{0 => zero_count, 1 => one_count} = Map.get(counts_map, pos)

    value = if one_count < zero_count do
      1
    else
      0
    end

    filtered = for i <- bin_lists, Enum.at(i, pos) == value, do: i

    if length(filtered) == 1 do
      filtered
    else
      filter_for_list_least_common(filtered, pos + 1)
    end
  end

  def part2() do
    input_list = read_input()

    bin_lists = for input_str <- input_list do
      for i <- to_charlist(input_str) do
        int_to_bin(i)
      end
    end

    oxygen_list = filter_for_list_most_common(bin_lists, 0)
    co2_list = filter_for_list_least_common(bin_lists, 0)

    oxygen = String.to_integer(Enum.join(Enum.at(oxygen_list, 0)), 2)
    co2 = String.to_integer(Enum.join(Enum.at(co2_list, 0)), 2)

    oxygen * co2
  end

end
