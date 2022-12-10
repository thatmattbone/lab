defmodule Day03 do


  # Lowercase item types a through z have priorities 1 through 26.
  # Uppercase item types A through Z have priorities 27 through 52.

  def build_priority_map() do
    lower = for i <- 1..26, do: {to_string([i + 96]), i}
    upper = for i <- 27..52, do: {to_string([i + 38]), i}
    Map.new(lower ++ upper)
  end

  def priority(priority_map, input_str) do
    Map.get(priority_map, input_str)
  end

  def add_to_count_map(count_map, str) do
    Map.update(count_map, str, [str], fn existing_list -> existing_list ++ [str] end)
  end

  def str_to_count_map(input_str) do
    String.split(input_str, "", trim: true)
      |> Enum.reduce(%{}, fn i, count_map -> add_to_count_map(count_map, i) end)
  end

  def find_intersection(map1, map2) do
    for {key, _value} <- map1, Map.has_key?(map2, key), into: [], do: key
  end

  def find_dupes_from_map(count_map) do
    dupes = Enum.filter(count_map, fn {_key, value} -> length(value) > 1 end)
    for {key, _value} <- dupes, do: key
  end

  def part1() do
    priority_map = build_priority_map()

    split_lines = File.read!("input/input_03")
      |> String.split("\n", trim: true)
      |> Enum.map(fn line ->
        half_len = String.length(line) / 2 |> trunc()
        [String.slice(line, 0, half_len), String.slice(line, half_len, half_len * 2)]
      end)

      # TODO clean all this up, unholy mix of comprehensions and maps here...
      dupes = for [first, second] <- split_lines, into: [], do: find_intersection(str_to_count_map(first), str_to_count_map(second))

      dupes |> List.flatten() |> Enum.map(fn x -> priority(priority_map, x) end) |> Enum.sum()
  end

  def find_intersection(map1, map2, map3) do
    for {key, _value} <- map1, Map.has_key?(map2, key) and Map.has_key?(map3, key), into: [], do: key
  end

  def part2_iter([], sum) do
    sum
  end

  def part2_iter([first, second, third | rest], sum) do
    map1 = str_to_count_map(first)
    map2 = str_to_count_map(second)
    map3 = str_to_count_map(third)

    intersection = find_intersection(map1, map2, map3)

    # TODO fix this and do not rebuild the priority map all over the place
    this_sum = Enum.sum(for dupe <- intersection, do: priority(build_priority_map(), dupe))

    part2_iter(rest, sum + this_sum)
  end

  def part2() do
    split_lines = File.read!("input/input_03")
      |> String.split("\n", trim: true)

    part2_iter(split_lines, 0)
  end
end
