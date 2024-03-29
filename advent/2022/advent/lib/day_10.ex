defmodule Day10 do

  def parse_line([noop]) when noop == "noop" do
    {:noop}
  end

  def parse_line([addx, value]) when addx == "addx" do
    {:addx, String.to_integer(value)}
  end

  def run_instruction({:noop}, register_val, cycle_count, cycle_record) do
    cycle_record = cycle_record
      |> Map.put(cycle_count, register_val)

    {register_val, cycle_count + 1, cycle_record}
  end

  def run_instruction({:addx, value}, register_val, cycle_count, cycle_record) do
    cycle_record = cycle_record
      |> Map.put(cycle_count, register_val)
      |> Map.put(cycle_count + 1, register_val)

    {register_val + value, cycle_count + 2, cycle_record}
  end

  def run_cpu([], _register_val, _cycle_count, cycle_record) do
    cycle_record
  end

  def run_cpu([instruction | rest], register_val, cycle_count, cycle_record) do
    {register_val, cycle_count, cycle_record} = run_instruction(instruction, register_val, cycle_count, cycle_record)

    run_cpu(rest, register_val, cycle_count, cycle_record)
  end

  def run_cpu(instructions) do
    run_cpu(instructions, 1, 1, %{})
  end

  def part1() do
    cycle_record = File.read!("input/input_10")
      |> String.split("\n", trim: true)
      |> Enum.map(fn line -> line |> String.split(" ") |> parse_line() end)
      |> run_cpu()

    #cycle_record
    #  |> Map.to_list()
    #  |> Enum.sort()
    #  |> IO.inspect(limit: :infinity)


      #20th, 60th, 100th, 140th, 180th, and 220th cycles
      20 * cycle_record[20] + 60 * cycle_record[60] + 100 * cycle_record[100] + 140 * cycle_record[140] + 180 * cycle_record[180] + 220 * cycle_record[220]
  end

  def val_to_pixel(value) do
    {value - 1, value, value + 1}
  end

  def pixel_value(cycle_count, {v1, v2, v3}) do
    cycle_count = rem(cycle_count, 40) - 1
    if cycle_count == v1 or cycle_count == v2 or cycle_count == v3 do
        "#"
      else
        "."
    end
  end

  def part2() do
    cycle_record = File.read!("input/input_10")
      |> String.split("\n", trim: true)
      |> Enum.map(fn line -> line |> String.split(" ") |> parse_line() end)
      |> run_cpu()

    pixels = cycle_record
      |> Map.to_list()
      |> Enum.sort()
      |> Enum.map(fn {cycle_count, register_val} -> {cycle_count, val_to_pixel(register_val)} end)
      |> Enum.map(fn {cycle_count, values} -> pixel_value(cycle_count, values) end)

    [r1, r2, r3, r4, r5, r6] = Enum.chunk_every(pixels, 40)

    #IO.puts(Enum.join(r1))
    #IO.puts(Enum.join(r2))
    #IO.puts(Enum.join(r3))
    #IO.puts(Enum.join(r4))
    #IO.puts(Enum.join(r5))
    #IO.puts(Enum.join(r6))

    #    ####.###...##..###..#....####.####.#..#.
    #    ...#.#..#.#..#.#..#.#....#.......#.#..#.
    #    ..#..#..#.#..#.#..#.#....###....#..#..#.
    #    .#...###..####.###..#....#.....#...#..#.
    #    #....#.#..#..#.#.#..#....#....#....#..#.
    #    ####.#..#.#..#.#..#.####.#....####..##..


    "ZRARLFZ"
  end


end
