defmodule Day12 do
  @type cave_description() :: [{String.t(), String.t()}]
  @type path_list() :: [String.t()]


  @spec parse_input :: cave_description()
  def parse_input do
    File.read!("input/input_12")
      |> String.split("\n", trim: true)
      |> Enum.flat_map(fn line ->
          [start_elem, end_elem] = String.split(line, "-")
          [{start_elem, end_elem}, {end_elem, start_elem}]
        end)
  end

  @spec is_big_cave?(String.t()) :: boolean
  def is_big_cave?(cave_name) do
    String.upcase(cave_name) == cave_name
  end

  @spec get_next_paths(cave_description(), String.t()) :: path_list()
  def get_next_paths(paths, curr_elem) do
    paths
     |> Enum.filter(fn {src, _dest} ->
          src == curr_elem
        end)
     |> Enum.map(fn {_src, dest} ->
          dest
        end)
  end

  @spec filter_next_paths(path_list(), path_list()) :: path_list()
  def filter_next_paths(next_paths, curr_path) do
    Enum.filter(next_paths, fn elem ->
      if Enum.member?(curr_path, elem) do
          is_big_cave?(elem)
        else
          true
      end
    end)
  end

  @spec find_paths(cave_description(), path_list()) :: [path_list()]
  def find_paths(paths, [curr_elem | curr_path]) do
    next_paths = get_next_paths(paths, curr_elem) |> filter_next_paths([curr_elem | curr_path])

    IO.inspect(curr_elem)
    IO.inspect(next_paths)
    require IEx; IEx.pry()

    if length(next_paths) == 0 do
      [curr_path]
    else
      Enum.map(next_paths, fn next_elem ->
        new_curr_path = [next_elem | curr_path]

        find_paths(paths, new_curr_path)
      end)
    end
  end

  @spec part1 :: integer()
  def part1() do
    input_list = parse_input()

    find_paths(input_list, ["start"])
      |> IO.inspect()
    1
  end

  @spec part2 :: integer()
  def part2() do
    2
  end

end
