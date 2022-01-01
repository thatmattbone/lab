defmodule Day12 do
  @type cave_description() :: [{String.t(), String.t()}]
  @type path_list() :: [String.t()]


  @spec parse_input :: cave_description()
  def parse_input do
    File.read!("input/input_12_test")
      |> String.split("\n", trim: true)
      |> Enum.flat_map(fn line ->
          [start_elem, end_elem] = String.split(line, "-")
          [{start_elem, end_elem}]
        end)
  end

  @spec is_big_cave?(String.t()) :: boolean
  def is_big_cave?(cave_name) do
    String.upcase(cave_name) == cave_name
  end

  @spec get_next_paths(cave_description(), String.t()) :: path_list()
  def get_next_paths(paths, curr_elem) do
    paths
     |> Enum.filter(fn {src, dest} ->
          src == curr_elem or (dest == curr_elem and src != curr_elem)
        end)
     |> Enum.map(fn {src, dest} ->
          if src == curr_elem do
            dest
          else
            src
          end
        end)
  end

  def filter_next_paths(next_paths, []) do
    next_paths
  end

  @spec filter_next_paths(path_list(), path_list()) :: path_list()
  def filter_next_paths(next_paths, [curr_elem | curr_path]) do
    next_paths
      |> Enum.filter(fn elem -> elem != curr_elem end)
      |> Enum.filter(fn elem ->
          if Enum.member?(curr_path, elem) do
            is_big_cave?(elem)
          else
            true
        end
      end)
  end

  def find_paths(_paths, [curr_elem | curr_path]) when curr_elem == "end" do
    [[curr_elem | curr_path]]
  end

  @spec find_paths(cave_description(), path_list()) :: [path_list()]
  def find_paths(paths, [curr_elem | curr_path]) do
    next_paths = get_next_paths(paths, curr_elem) |> filter_next_paths([curr_elem | curr_path])

    #IO.inspect(curr_elem)
    #IO.inspect(curr_path)
    #IO.inspect(next_paths)
    #require IEx; IEx.pry()

    if length(next_paths) == 0 do
      [[curr_elem | curr_path]]
    else
      Enum.reduce(next_paths, [], fn next_elem, acc ->
        new_curr_path = [next_elem, curr_elem | curr_path]

        find_paths(paths, new_curr_path) ++ acc
      end)
    end
  end

  @spec part1 :: integer()
  def part1() do
    input_list = parse_input()

    find_paths(input_list, ["start"])
      |> IO.inspect(limit: :infinity)
    1
  end

  @spec part2 :: integer()
  def part2() do
    2
  end

end
