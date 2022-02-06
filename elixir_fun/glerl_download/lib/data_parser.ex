defmodule DataParser do

  def parse(input_str) do
    [_head1, _head2 | lines] = String.split(input_str, "\n")

    lines
      |> Enum.map(fn line ->
        String.trim(line)
          |> String.split(" ")
          |> Enum.filter(fn item -> String.length(item) > 0 end)
      end)
  end
end
