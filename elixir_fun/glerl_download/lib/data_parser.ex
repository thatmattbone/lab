defmodule DataParser do

  def input_str_to_lines(input_str) do
    [_head1, _head2 | lines] = String.trim(input_str) |> String.split("\n")

    lines
      |> Enum.map(fn line ->
        String.trim(line)
          |> String.split(" ")
          |> Enum.filter(fn item -> String.length(item) > 0 end)
      end)
      |> Enum.filter(fn [item1 | _rest] -> item1 == "4" end)
  end

  def parse_utc(utc_str) do
    String.to_integer(utc_str)  # TODO do more with this
  end

  def line_to_typed_line([id, year, doy, utc, temp_c, speed, gusts, direction]) do
    [
      String.to_integer(id),
      String.to_integer(year),
      String.to_integer(doy),
      parse_utc(utc),
      String.to_float(temp_c),
      String.to_float(speed),
      String.to_float(gusts),
      String.to_integer(direction)
    ]
  end

  def parse(input_str) do
    input_str_to_lines(input_str)
      #|> IO.inspect(limit: :infinity)
      |> Enum.map(&line_to_typed_line/1)
  end
end
