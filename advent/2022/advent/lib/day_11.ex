defmodule Day11 do

  def build_initial_monkeys() do
    %{
      0 => %{
        :items => [93, 54, 69, 66, 71],
        :inspected => 0,
        :op => fn old -> old * 3 end,
        :throw_to => fn item ->
          if rem(item, 7) == 0 do
            7
          else
            1
          end
        end,
      },
      1 => %{
        :items => [89, 51, 80, 66],
        :inspected => 0,
        :op => fn old -> old * 17 end,
        :throw_to => fn item ->
          if rem(item, 19) == 0 do
            5
          else
            7
          end
        end,
      },
      2 => %{
        :items => [90, 92, 63, 91, 96, 63, 64],
        :inspected => 0,
        :op => fn old -> old + 1 end,
        :throw_to => fn item ->
          if rem(item, 13) == 0 do
            4
          else
            3
          end
        end,
      },
      3 => %{
        :items => [65, 77],
        :inspected => 0,
        :op => fn old -> old + 2 end,
        :throw_to => fn item ->
          if rem(item, 3) == 0 do
            4
          else
            6
          end
        end,
      },
      4 => %{
        :items => [76, 68, 94],
        :inspected => 0,
        :op => fn old -> old * old end,
        :throw_to => fn item ->
          if rem(item, 2) == 0 do
            0
          else
            6
          end
        end,
      },
      5 => %{
        :items => [86, 65, 66, 97, 73, 83],
        :inspected => 0,
        :op => fn old -> old + 8 end,
        :throw_to => fn item ->
          if rem(item, 11) == 0 do
            2
          else
            3
          end
        end,
      },
      6 => %{
        :items => [78],
        :inspected => 0,
        :op => fn old -> old + 6 end,
        :throw_to => fn item ->
          if rem(item, 17) == 0 do
            0
          else
            1
          end
        end,
      },
      7 => %{
        :items => [89, 57, 59, 61, 87, 55, 55, 88],
        :inspected => 0,
        :op => fn old -> old + 7 end,
        :throw_to => fn item ->
          if rem(item, 5) == 0 do
            2
          else
            5
          end
        end,
        },
    }
  end

  def new_worry_level(level, div) do
      if div == 3 do
        floor(level/div)
      else
        rem(level, div)
      end
  end

  def run_turn(monkey_map, monkey_num, div) do
    %{
      :items => items,
      :op => op,
      :throw_to => throw_to
    } = monkey_map[monkey_num]

    Enum.reduce(items, monkey_map, fn(item, monkey_map) ->
      worry_level = op.(item) |> new_worry_level(div)
      throw_to_monkey = throw_to.(worry_level)
      inspected = monkey_map[monkey_num].inspected + 1

      new_item_list = monkey_map[throw_to_monkey].items ++ [worry_level]

      monkey_map
        |> put_in([monkey_num, :items], [])
        |> put_in([monkey_num, :inspected], inspected)
        |> put_in([throw_to_monkey, :items], new_item_list)
    end)
  end

  def run_round(monkey_map, div) do
    Enum.reduce(0..7, monkey_map, fn(item, monkey_map) ->
      run_turn(monkey_map, item, div)
    end)
  end

  def part1() do
    monkey_map = Enum.reduce(1..20, build_initial_monkeys(), fn(_item, monkey_map) -> run_round(monkey_map, 3) end)

    [biggest, second_biggest | _rest] = Enum.map(0..7, fn x -> monkey_map[x].inspected end) |> Enum.sort(:desc)

    biggest * second_biggest
  end


  def part2() do
    # cheated on this 9699690 number, it's the product of all the numbers in the "divisible" by tests
    # I knew it was something like this but was annoyed and looked it up...
    monkey_map = Enum.reduce(1..10000, build_initial_monkeys(), fn(_item, monkey_map) -> run_round(monkey_map, 9699690) end)

    [biggest, second_biggest | _rest] = Enum.map(0..7, fn x -> monkey_map[x].inspected end) |> Enum.sort(:desc)

    biggest * second_biggest
  end
end
