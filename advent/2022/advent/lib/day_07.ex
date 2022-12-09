defmodule Day07 do

  def build_dir_struct([], cwd) do
    cwd
  end

  def build_dir_struct([{:ls} | instructions], cwd) do
    #IO.inspect("ls")
    #IO.inspect(parent)
    build_dir_struct(instructions, cwd)
  end

  def build_dir_struct([{:cd, dir_name} | instructions], cwd) when dir_name == ".." do
    build_dir_struct(instructions, Map.get(cwd, :parent))
  end

  def build_dir_struct([{:cd, dir_name} | instructions], cwd) do
    #new_dest = cwd |> Map.get(:sub_dirs) |> Map.get(dir_name)
    #new_dest = Map.put(new_dest, :parent, cwd)
    #build_dir_struct(instructions, new_dest)
    cwd
  end

  def build_dir_struct([{:dir, dir_name} | instructions], cwd) do
    new_dir = %{
      :name => dir_name,
      :sub_dirs => %{},
      :files => %{},
      :parent => nil,
    }
    cwd = put_in(cwd, [:sub_dirs, dir_name], new_dir)
    build_dir_struct(instructions, cwd)
  end

  def build_dir_struct([{:file, size, filename} | instructions], cwd) do
    cwd = put_in(cwd, [:files, filename], size)
    build_dir_struct(instructions, cwd)
  end

  def build_dir_struct([{:cd, dir} | instructions]) when dir == "/" do
    root = %{
      :name => dir,
      :sub_dirs => %{},
      :files => %{},
      :parent => nil,
    }
    build_dir_struct(instructions, root)
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
    {:file, filesize, filename}
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
