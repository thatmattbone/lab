defmodule Day04 do

  def is_total_overlap({{e1_start, e1_end}, {e2_start, e2_end}}) when e1_start >= e2_start and e1_end <= e2_end do
    true
  end

  def is_total_overlap({{e1_start, e1_end}, {e2_start, e2_end}}) when e2_start >= e1_start and e2_end <= e1_end do
    true
  end

  def is_total_overlap({{e1_start, e1_end}, {e2_start, e2_end}}) do
    false
  end

  def part1() do
    input = File.read!("input/input_04")
      |> String.split("\n", trim: true)
      |> Enum.map(fn line ->
        [first_elf, second_elf] = String.split(line, ",")

        [[e1_start_str, e1_end_str], [e2_start_str, e2_end_str]] = [String.split(first_elf, "-"), String.split(second_elf, "-")]

        {
          {String.to_integer(e1_start_str), String.to_integer(e1_end_str)},
          {String.to_integer(e2_start_str), String.to_integer(e2_end_str)},
        }
      end)

      input
        |> Enum.filter(&is_total_overlap/1)
        |> length()
  end

end
