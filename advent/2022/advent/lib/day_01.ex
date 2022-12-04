defmodule Day01 do

  def elf_bucket_sums() do
    elf_buckets = File.read!("input/input_01")
      |> String.split("\n\n")
      |> Enum.map(fn x ->
        x |> String.split() |> Enum.map(&String.to_integer/1)
      end)

    Enum.map(elf_buckets, fn x -> Enum.sum(x) end)
  end

  def part1() do
    Enum.max(elf_bucket_sums())
  end

  def part2() do
    Enum.sort(elf_bucket_sums(), :desc)
      |> Enum.slice(0, 3)
      |> Enum.sum()
  end
end
