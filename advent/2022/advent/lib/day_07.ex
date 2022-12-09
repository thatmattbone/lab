defmodule Day07 do

  def new_dir(dir_name) do
    %{
      :name => dir_name,
      :sub_dirs => %{},
      :files => %{},
    }
  end

  def new_dir(dir_name, cwd, root) do
    [_ | put_spec] = cwd |> Enum.reverse() |> Enum.intersperse(:sub_dirs)

    put_spec = put_spec ++ [:sub_dirs, dir_name]

    put_in(root, put_spec, new_dir(dir_name))
  end

  def new_file(filesize, filename, cwd, root) do
    [_ | put_spec] = cwd |> Enum.reverse() |> Enum.intersperse(:sub_dirs)
    put_spec = put_spec ++ [:files, filename]

    put_in(root, put_spec, filesize)
  end

  def build_dir_struct([], _cwd, root) do
    root
  end

  def build_dir_struct([{:ls} | instructions], cwd, root) do
    build_dir_struct(instructions, cwd, root)
  end

  def build_dir_struct([{:cd, dir_name} | instructions], cwd, root) when dir_name == ".." do
    #IO.inspect("UP A DIR")
    [_ | new_cwd] = cwd
    build_dir_struct(instructions, new_cwd, root)
  end

  def build_dir_struct([{:cd, dir_name} | instructions], _cwd, root) when dir_name == "/" do
    #IO.inspect("CHANGE TO ROOT")

    new_cwd = ["/"]
    build_dir_struct(instructions, new_cwd, root)
  end

  def build_dir_struct([{:cd, dir_name} | instructions], cwd, root) do
    #IO.inspect("CHANGE TO #{dir_name}")
    new_cwd = [dir_name | cwd]
    build_dir_struct(instructions, new_cwd, root)
  end

  def build_dir_struct([{:dir, dir_name} | instructions], cwd, root) do
    new_root = new_dir(dir_name, cwd, root)

    build_dir_struct(instructions, cwd, new_root)
  end

  def build_dir_struct([{:file, size, filename} | instructions], cwd, root) do
    new_root = new_file(size, filename, cwd, root)
    build_dir_struct(instructions, cwd, new_root)
  end

  def build_dir_struct([{:cd, dir_name} | instructions]) when dir_name == "/" do
    build_dir_struct(instructions, ["/"], new_dir(dir_name))
  end

  def line_to_instruction([prompt, cd, dir_name]) when prompt == "$" and cd == "cd" do
    {:cd, dir_name}
  end

  def line_to_instruction([prompt, ls]) when prompt == "$" and ls == "ls" do
    {:ls}
  end

  def line_to_instruction([dir, dir_name]) when dir == "dir" do
    {:dir, dir_name}
  end

  def line_to_instruction([filesize, filename]) do
    {:file, String.to_integer(filesize), filename}
  end

  def dir_size(dir_struct) do
    my_filesize = dir_struct[:files]
      |> Map.values()
      |> Enum.sum()

    list_of_subdir_sizes = dir_struct[:sub_dirs]
      |> Map.values()
      |> Enum.map(&dir_size/1)

    my_subdir_size = list_of_subdir_sizes
      |> Enum.map(fn {_, size, _} -> size end)
      |> Enum.sum()

    {dir_struct[:name], my_filesize + my_subdir_size, list_of_subdir_sizes}
  end

  def flatten_dir_size({dir_name, size, []}) do
    [{dir_name, size}]
  end

  def flatten_dir_size({dir_name, size, subdirs}) do
    [{dir_name, size}] ++ (for subdir <- subdirs, do: flatten_dir_size(subdir), into: [])
  end

  def part1() do
    dir_struct = File.read!("input/input_07")
      |> String.split("\n", trim: true)
      |> Enum.map(fn line ->
         line |> String.split(" ", trim: true) |> line_to_instruction()
        end)
      #|> IO.inspect(limit: :infinity)
      |> build_dir_struct()

    #IO.inspect(dir_struct)

    # 1571315 is too low

    dir_size(dir_struct)
      |> flatten_dir_size()
      |> List.flatten()
      |> Enum.filter(fn {_name, size} -> size <= 100000 end)
      |> Enum.map(fn {_name, size} -> size end)
      |> Enum.sum()
  end


  def fuck() do
    shit = "$ cd /
    $ ls
    dir a
    14848514 b.txt
    8504156 c.dat
    dir d
    $ cd a
    $ ls
    dir e
    29116 f
    2557 g
    62596 h.lst
    $ cd e
    $ ls
    584 i
    $ cd ..
    $ cd ..
    $ cd d
    $ ls
    4060174 j
    8033020 d.log
    5626152 d.ext
    7214296 k"

    dir_struct = shit
      |> String.split("\n", trim: true)
      |> Enum.map(fn line ->
         line |> String.split(" ", trim: true) |> line_to_instruction()
        end)
      |> build_dir_struct()


    dir_size(dir_struct)
      |> IO.inspect()
      |> Enum.filter(fn {_name, size} -> size <= 100000 end)
      |> Enum.map(fn {_name, size} -> size end)
      |> Enum.sum()
  end

  def part2() do

  end
end
