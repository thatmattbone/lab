defmodule  Downloader do

  @spec get_data_dir :: String.t()
  def get_data_dir() do
    "data"
  end

  def create_data_dir() do
    if not File.exists?(get_data_dir()) do
      File.mkdir!(get_data_dir())
    end
  end

  @spec filename_from_year(integer()) :: String.t()
  def filename_from_year(year) when year >= 2001 and year < 2022 do
    "chi#{year}.04t.txt"
  end
end
