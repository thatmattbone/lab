defmodule Day01 do

  def day_01_part_1 do
    # IO.puts(File.cwd!())
    body = File.read!("lib/input_01")
    split_body = String.split(body, "\n")
    IO.inspect(split_body)
    input_list = for i <- split_body, String.length(i) > 0, do: String.to_integer(i)

    IO.inspect(input_list)
    input_list_product = for i <- input_list,
                             j <- input_list, do: {i, j}

    sum_to_2020 = for {i, j} <- input_list_product, i + j == 2020, do: {i, j}
    IO.inspect(sum_to_2020)

    #should return 793524

    1
  end

end
