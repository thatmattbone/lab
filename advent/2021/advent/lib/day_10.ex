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

  @cost %{")" => 3, "]" => 57, "}" => 1197, ">" => 25137}

  @cost2 %{")" => 1, "]" => 2, "}" => 3, ">" => 4}

  def line_info([hd | tail], stack) when length(stack) == 0 do
    if MapSet.member?(@opening_tags, hd) do
        line_info(tail, [hd | stack])
      else
        {:corrupt, hd}
    end
  end

  def line_info([hd | tail], stack) do
    cond do
      MapSet.member?(@opening_tags, hd) ->
        line_info(tail, [hd | stack])

      MapSet.member?(@closing_tags, hd) and hd(stack) == @tag_map[hd] ->
        line_info(tail, tl(stack))

      MapSet.member?(@closing_tags, hd) ->
        {:corrupt, hd}

      true ->
        {:error, {[hd | tail], stack}}
    end
  end

  def line_info([], stack) when length(stack) == 0 do
    {:complete, 0}
  end

  def line_info([], stack) do
    {:incomplete, stack}
  end

  def line_info(line) do
    Day10.line_info(line, [])
  end


  def part1() do
    File.read!("input/input_10")
      |> String.split("\n", trim: true)
      |> Enum.map(fn line -> String.split(line, "", trim: true) end)
      |> Enum.map(fn line -> line_info(line) end)
      |> Enum.filter(&match?({:corrupt, _}, &1))
      |> Enum.map(fn {:corrupt, item} -> @cost[item] end)
      |> Enum.sum()
  end

  def part2() do
    File.read!("input/input_10")
      |> String.split("\n", trim: true)
      |> Enum.map(fn line -> String.split(line, "", trim: true) end)
      |> Enum.map(fn line -> line_info(line) end)
      |> Enum.filter(&match?({:incomplete, _}, &1))
      |> Enum.map(fn {:incomplete, stack} ->
          Enum.map(stack, fn opening -> @tag_map[opening] end)
        end)
      |> Enum.map(fn tags ->
          Enum.reduce(tags, 0, fn elem, acc ->
            acc * 5 + @cost2[elem]
          end)
        end)
      |> Enum.sort()
      |> Enum.at(23)
  end
end
