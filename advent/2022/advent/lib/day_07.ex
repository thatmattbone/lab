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
    [_ | new_cwd] = cwd
    build_dir_struct(instructions, new_cwd, root)
  end

  def build_dir_struct([{:cd, dir_name} | instructions], cwd, root) do
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
    IO.inspect(Map.get(dir_struct, :name))

    my_filesize = dir_struct |> Map.get(:files) |> Map.values() |> Enum.sum()

    sub_dirs = dir_struct |> Map.get(:sub_dirs) |> Map.values() |> Enum.map(&dir_size/1) |> List.flatten()

    sub_dir_size = Enum.map(sub_dirs, fn {_dir, size} -> size end) |> Enum.sum()

    List.flatten([{Map.get(dir_struct, :name), my_filesize + sub_dir_size} | sub_dirs])
  end

  def part1() do
    dir_struct = File.read!("input/input_07")
      |> String.split("\n", trim: true)
      |> Enum.map(fn line ->
         line |> String.split(" ", trim: true) |> line_to_instruction()
        end)
      |> build_dir_struct()

    #IO.inspect(dir_struct)

    dir_size(dir_struct)
      |> Enum.filter(fn {_name, size} -> size <= 100000 end)
      |> Enum.map(fn {_name, size} -> size end)
      |> Enum.sum()
  end


  def part2() do

  end
end
