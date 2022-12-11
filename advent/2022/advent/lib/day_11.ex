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
        :unworry => fn item ->
          if rem(item, 7) == 0 do
            floor(item / 7)
          else
            item
          end
        end
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
        :unworry => fn item ->
          if rem(item, 19) == 0 do
            floor(item / 19)
          else
            item
          end
        end
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
        :unworry => fn item ->
          if rem(item, 13) == 0 do
            floor(item / 13)
          else
            item
          end
        end
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
        :unworry => fn item ->
          if rem(item, 3) == 0 do
            floor(item / 3)
          else
            item
          end
        end
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
        :unworry => fn item ->
          if rem(item, 2) == 0 do
            floor(item / 2)
          else
            item
          end
        end
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
        :unworry => fn item ->
          if rem(item, 11) == 0 do
            floor(item / 11)
          else
            item
          end
        end
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
        :unworry => fn item ->
          if rem(item, 17) == 0 do
            floor(item / 17)
          else
            item
          end
        end
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
        :unworry => fn item ->
          if rem(item, 5) == 0 do
            floor(item / 5)
          else
            item
          end
        end
        },
    }
  end

  def new_worry_level(level) do
      floor(level/3)
  end

  def run_turn(monkey_map, monkey_num) do
    %{
      :items => items,
      :op => op,
      :throw_to => throw_to
    } = monkey_map[monkey_num]

    Enum.reduce(items, monkey_map, fn(item, monkey_map) ->
      worry_level = op.(item) |> new_worry_level()
      throw_to_monkey = throw_to.(worry_level)
      inspected = monkey_map[monkey_num].inspected + 1

      new_item_list = monkey_map[throw_to_monkey].items ++ [worry_level]

      monkey_map
        |> put_in([monkey_num, :items], [])
        |> put_in([monkey_num, :inspected], inspected)
        |> put_in([throw_to_monkey, :items], new_item_list)
    end)
  end

  def run_round(monkey_map) do
    Enum.reduce(0..7, monkey_map, fn(item, monkey_map) ->
      run_turn(monkey_map, item)
    end)
  end

  def part1() do
    monkey_map = Enum.reduce(1..20, build_initial_monkeys(), fn(_item, monkey_map) -> run_round(monkey_map) end)

    [biggest, second_biggest | _rest] = Enum.map(0..7, fn x -> monkey_map[x].inspected end) |> Enum.sort(:desc)

    biggest * second_biggest
  end

  def run_turn2(monkey_map, monkey_num) do
    %{
      :items => items,
      :op => op,
      :throw_to => throw_to,
      :unworry => unworry,
    } = monkey_map[monkey_num]

    Enum.reduce(items, monkey_map, fn(item, monkey_map) ->
      worry_level = op.(item)
      throw_to_monkey = throw_to.(worry_level)
      inspected = monkey_map[monkey_num].inspected + 1

      worry_level = unworry.(worry_level)

      new_item_list = monkey_map[throw_to_monkey].items ++ [worry_level]

      monkey_map
        |> put_in([monkey_num, :items], [])
        |> put_in([monkey_num, :inspected], inspected)
        |> put_in([throw_to_monkey, :items], new_item_list)
    end)
  end

  def run_round2(monkey_map) do
    Enum.reduce(0..7, monkey_map, fn(item, monkey_map) ->
      run_turn2(monkey_map, item)
    end)
  end

  def part2() do
    monkey_map = Enum.reduce(1..10000, build_initial_monkeys(), fn(_item, monkey_map) -> run_round2(monkey_map) end)

    [biggest, second_biggest | _rest] = Enum.map(0..7, fn x -> monkey_map[x].inspected end) |> Enum.sort(:desc)

    biggest * second_biggest
  end
end
