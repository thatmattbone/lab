defmodule Day10 do

  @opening_tags MapSet.new(["(", "[", "{", "<"])

  @closing_tags MapSet.new([")", "]", "}", ">"])

  @tag_map  %{
    "(" => ")",
    ")" => "(",

    "[" => "]",
    "]" => "[",

    "{" => "}",
    "}" => "{",

    "<" => ">",
    ">" => "<",
  }

  def line_info([hd | tail], stack) when length(stack) == 0 do
    if MapSet.member?(@opening_tags, hd) do
        line_info(tail, [hd | stack])
      else
        {:corrupt, hd}
    end
  end

  def line_info([], stack) when length(stack) == 0 do
    {:complete, 0}
  end

  def line_info([], stack) do
    {:incomplete, length(stack)}
  end

  def line_info(line) do
    Day10.line_info(line, [])
  end


  def part1() do
    File.read!("input/input_10")
      |> String.split("\n", trim: true)
      |> Enum.map(fn line -> String.split(line, "", trim: true) end)
      #|> Enum.map(fn line -> Day10.line_info(line) end)

    1
  end

  def part2() do
    2
  end
end
