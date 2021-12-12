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
    IO.puts(num_days)

    evolved = initial_state
      |> Enum.map(&Day06.evolve_one_day/1)

    evolved_fish = for {i, _j} <- evolved, do: i
    new_fish = for {_i, j} <- evolved, j != nil, do: j

    evolve_list_slow(evolved_fish ++ new_fish, num_days - 1)  # slow...
  end

  def sum_list_slow(initial_state, num_days) do
    length(Day06.evolve_list_slow(initial_state, num_days))
  end

  def evolve_list_fast(initial_state, num_days) do
    lookup = %{
      1 => evolve_list_slow([1], num_days) |> length(),
      2 => evolve_list_slow([2], num_days) |> length(),
      3 => evolve_list_slow([3], num_days) |> length(),
      4 => evolve_list_slow([4], num_days) |> length(),
      5 => evolve_list_slow([5], num_days) |> length(),
      6 => evolve_list_slow([6], num_days) |> length(),
    }
    IO.puts("built lookup table")

    initial_state
      |> Enum.map(fn x -> Map.get(lookup, x) end)
      |> Enum.sum()
  end

  def part1() do
    Day06.evolve_list_fast(parse_lines(), 80)
  end

  def part2() do
    Day06.evolve_list_fast(parse_lines(), 256)
  end
end
