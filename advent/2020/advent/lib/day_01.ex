defmodule Day01 do

  def day_01_part_1 do
    # IO.puts(File.cwd!())
    body = File.read!("lib/input_01")
    split_body = String.split(body, "\n")
    IO.inspect(split_body)
    input_list = for i <- split_body, String.length(i) > 0, do: String.to_integer(i)
    IO.inspect(input_list)
    1
  end

end
