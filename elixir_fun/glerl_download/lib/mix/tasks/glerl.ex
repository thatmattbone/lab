defmodule Mix.Tasks.Glerl do
  def run(_) do
    result = ArchiveDownloader.read_file_for_year(2011)

    IO.inspect(DataParser.parse(result))
  end
end
