defmodule Day12 do
  @type cave_description() :: [{String.t(), String.t()}]
  @type path_list() :: [String.t()]


  @spec parse_input :: cave_description()
  def parse_input do
    File.read!("input/input_12")
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

    next_paths = paths
      |> get_next_paths(curr_elem)
      |> filter_next_paths([curr_elem | curr_path])

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
      |> Enum.filter(fn path -> hd(path) == "end" end)
      |> length()
  end

  def has_a_dupe?([], _already_seen) do
    false
  end

  def has_a_dupe?([head | tail], already_seen) do
    if MapSet.member?(already_seen, head) do
      true
    else
      has_a_dupe?(tail, MapSet.put(already_seen, head))
    end
  end

  def has_a_dupe?(path_list) do
    has_a_dupe?(path_list, MapSet.new())
  end

  @spec filter_next_paths_part2(path_list(), path_list()) :: path_list()
  def filter_next_paths_part2(next_paths, [curr_elem | curr_path]) do
    next_paths
      |> Enum.filter(fn elem -> elem != curr_elem end)
      |> Enum.filter(fn elem ->
          we_have_seen = Enum.count(curr_path, fn x -> x == elem end)

          if we_have_seen < 2 do
            true
          else
            is_big_cave?(elem)
          end
        end)
  end

  def find_paths_part2(_paths, [curr_elem | curr_path]) when curr_elem == "end" do
    [[curr_elem | curr_path]]
  end

  def find_paths_part2(_paths, [curr_elem, next_elem | curr_path]) when curr_elem == "start" do
    [[next_elem | curr_path]]
  end

  @spec find_paths_part2(cave_description(), path_list()) :: [path_list()]
  def find_paths_part2(paths, [curr_elem | curr_path]) do
    next_paths = paths
      |> get_next_paths(curr_elem)
      |> filter_next_paths_part2([curr_elem | curr_path])

    if length(next_paths) == 0 do
      [[curr_elem | curr_path]]
    else
      Enum.reduce(next_paths, [], fn next_elem, acc ->
        new_curr_path = [next_elem, curr_elem | curr_path]

        IO.inspect(new_curr_path)

        find_paths_part2(paths, new_curr_path) ++ acc
      end)
    end
  end

  @spec part2 :: integer()
  def part2() do
    input_list = parse_input()

    #find_paths_part2(input_list, ["start"])
    #  |> Enum.filter(fn path -> hd(path) == "end" end)
    #  |> IO.inspect(limit: :infinity)
    #  |> length()
    2
    end
end
