defmodule Day11 do

  def build_initial_monkeys() do
    %{
      0 => %{
        :items => [93, 54, 69, 66, 71],
        :op => fn old -> old * 3 end,
        :throw_to => fn item ->
          if rem(item, 7) == 0 do
            7
          else
            1
          end
        end
      },
      1 => %{
        :items => [89, 51, 80, 66],
        :op => fn old -> old * 17 end,
        :throw_to => fn item ->
          if rem(item, 19) == 0 do
            5
          else
            7
          end
        end
      },
      2 => %{
        :items => [90, 92, 63, 91, 96, 63, 64],
        :op => fn old -> old + 1 end,
        :throw_to => fn item ->
          if rem(item, 13) == 0 do
            4
          else
            3
          end
        end
      },
      3 => %{
        :items => [65, 77],
        :op => fn old -> old + 2 end,
        :throw_to => fn item ->
          if rem(item, 3) == 0 do
            4
          else
            6
          end
        end
      },
      4 => %{
        :items => [76, 68, 94],
        :op => fn old -> old * old end,
        :throw_to => fn item ->
          if rem(item, 2) == 0 do
            0
          else
            6
          end
        end
      },
      5 => %{
        :items => [86, 65, 66, 97, 73, 83],
        :op => fn old -> old + 8 end,
        :throw_to => fn item ->
          if rem(item, 11) == 0 do
            2
          else
            3
          end
        end
      },
      6 => %{
        :items => [78],
        :op => fn old -> old + 6 end,
        :throw_to => fn item ->
          if rem(item, 17) == 0 do
            0
          else
            1
          end
        end
      },
      7 => %{
        :items => [89, 57, 59, 61, 87, 55, 55, 88],
        :op => fn old -> old + 7 end,
        :throw_to => fn item ->
          if rem(item, 5) == 0 do
            2
          else
            5
          end
        end
        },
    }
  end

  def part1() do

  end

  def part2() do

  end

end
