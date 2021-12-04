defmodule Day02 do

  def calc_new_position({instruction, magnitude}, {depth, position}) when instruction == "forward" do
    {depth, position + magnitude}
  end

  def calc_new_position({instruction, magnitude}, {depth, position}) when instruction == "down" do
    {depth + magnitude, position}
  end

  def calc_new_position({instruction, magnitude}, {depth, position}) when instruction == "up" do
    {depth - magnitude, position}
  end

  def find_position([], current_position) do
    current_position
  end

  def find_position([head|tail], current_position) do
    find_position(tail, calc_new_position(head, current_position))
  end

  def part1() do
    body = File.read!("input/input_02")
    split_body = String.split(body, "\n")
    instructions_and_magnitudes = for i <- split_body, String.length(i) > 0 do
      [instruction, magnitude] = String.split(i, " ")
      {instruction, String.to_integer(magnitude)}
    end

    find_position(instructions_and_magnitudes, {0, 0})
  end

  def part2() do
    2
  end
end
