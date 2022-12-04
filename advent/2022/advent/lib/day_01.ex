defmodule Day01 do

  def part1() do
    elf_buckets = File.read!("input/input_01")
      |> String.split("\n\n")
      |> Enum.map(fn x ->
        x |> String.split() |> Enum.map(&String.to_integer/1)
      end)

    elf_bucket_sums = Enum.map(elf_buckets, fn x -> Enum.sum(x) end)

    Enum.max(elf_bucket_sums)
  end
end
