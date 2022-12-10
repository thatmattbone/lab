defmodule Day04 do

  def line_to_elf_tuples(line) do
    [first_elf, second_elf] = String.split(line, ",")

    [[e1_start_str, e1_end_str], [e2_start_str, e2_end_str]] = [String.split(first_elf, "-"), String.split(second_elf, "-")]

    {
      {String.to_integer(e1_start_str), String.to_integer(e1_end_str)},
      {String.to_integer(e2_start_str), String.to_integer(e2_end_str)},
    }
  end

  def is_total_overlap({{e1_start, e1_end}, {e2_start, e2_end}}) when e1_start >= e2_start and e1_end <= e2_end do
    true
  end

  def is_total_overlap({{e1_start, e1_end}, {e2_start, e2_end}}) when e2_start >= e1_start and e2_end <= e1_end do
    true
  end

  def is_total_overlap({{_e1_start, _e1_end}, {_e2_start, _e2_end}}) do
    false
  end

  def calc_overlap({{e1_start, e1_end}, {e2_start, e2_end}}) do
    e1_set = MapSet.new(Range.new(e1_start, e1_end))
    e2_set = MapSet.new(Range.new(e2_start, e2_end))

    MapSet.intersection(e1_set, e2_set) |> MapSet.size()
  end

  def part1() do
    input = File.read!("input/input_04")
      |> String.split("\n", trim: true)
      |> Enum.map(&line_to_elf_tuples/1)

    input
      |> Enum.filter(&is_total_overlap/1)
      |> length()
  end

  def part2() do
    input = File.read!("input/input_04")
      |> String.split("\n", trim: true)
      |> Enum.map(&line_to_elf_tuples/1)

    input
      |> Enum.map(&calc_overlap/1)
      |> Enum.filter(fn x -> x > 0 end)
      |> Enum.count()
  end

end
