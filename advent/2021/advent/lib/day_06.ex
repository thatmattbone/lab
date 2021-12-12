defmodule Day06 do

  def parse_lines() do
    File.read!("input/input_06")
      |> String.split("\n", trim: true)
      |> hd()
      |> String.split(",", trim: true)
      |> Enum.map(&String.to_integer/1)
  end

  def evolve_one_day(n) when n == 0 do
    {6, 8}
  end

  def evolve_one_day(n) do
    {n - 1, nil}
  end

  def evolve_list_slow(initial_state, num_days) when num_days == 0 do
    initial_state
  end

  def evolve_list_slow(initial_state, num_days) do
    evolved = initial_state
      |> Enum.map(&Day06.evolve_one_day/1)

    evolved_fish = for {i, _j} <- evolved, do: i
    new_fish = for {_i, j} <- evolved, j != nil, do: j

    evolve_list_slow(evolved_fish ++ new_fish, num_days - 1)  # slow...
  end

  def sum_list_slow(initial_state, num_days) do
    length(Day06.evolve_list_slow(initial_state, num_days))
  end

  def part1() do
    #Day06.sum_list_slow(parse_lines(), 80)
    Day06.sum_list_fast(parse_lines(), 80)
  end

  def freq_sum({fish0, fish1, fish2, fish3, fish4, fish5, fish6, fish7, fish8}) do
    {fish1, fish2, fish3, fish4, fish5, fish6, fish7 + fish0, fish8, fish0}
  end

  def sum_list_fast(initial_list, num_days) do
    freqs = initial_list
      |> Enum.frequencies()
    initial = Enum.map(0..8, fn i -> freqs[i] || 0 end) |> List.to_tuple()

    1..num_days
      |> Enum.reduce(initial, fn _, x -> freq_sum(x) end)
      |> Tuple.sum()
  end

  def part2() do
    sum_list_fast(parse_lines(), 256)
  end
end
