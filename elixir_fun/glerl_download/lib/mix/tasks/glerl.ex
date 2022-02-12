defmodule Mix.Tasks.Glerl do
  def run(_) do
    IO.puts("starting")

    all_years =
      for year <- 2000..2020 do
        IO.puts(year)

        ArchiveDownloader.read_file_for_year(year)
        |> DataParser.parse()
      end

    IO.puts("done with parsing")

    all_years_flat = Enum.flat_map(all_years, fn x -> x end)

    IO.puts(length(all_years_flat))
    # IO.inspect(DataParser.parse(result))
  end
end
