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

  def evolve_list(initial_state, num_days) when num_days == 0 do
    initial_state
  end

  def evolve_list(initial_state, num_days) do
    IO.puts(num_days)
    IO.puts(length(initial_state))

    evolved = initial_state
      |> Enum.map(&Day06.evolve_one_day/1)

    evolved_fish = for {i, _j} <- evolved, do: i
    new_fish = for {_i, j} <- evolved, j != nil, do: j

    evolve_list(evolved_fish ++ new_fish, num_days - 1)  # slow...
  end

  def part1() do
    parse_lines()
      |> evolve_list(80)
      |> length()
  end

  def part2() do
    parse_lines()
      |> evolve_list(256)
      |> length()  end
end
