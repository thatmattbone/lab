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

  def part1() do
    instructions = File.read!("input/input_07")
      |> String.split("\n", trim: true)
      |> Enum.map(fn line ->
         line |> String.split(" ", trim: true) |> line_to_instruction()
        end)
      |> IO.inspect()

    build_dir_struct(instructions)
  end


  def part2() do

  end
end
