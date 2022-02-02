defmodule  Downloader do

  @min_year 2000
  @max_year 2022

  @spec get_data_dir :: String.t()
  def get_data_dir() do
    "data"
  end

  def create_data_dir() do
    if not File.exists?(get_data_dir()) do
      File.mkdir!(get_data_dir())
    end
  end

  @spec filename_for_year(integer()) :: String.t()
  def filename_for_year(year) when year >= @min_year and year < @max_year do
    "chi#{year}.04t.txt"
  end

  @spec url_for_year(integer()) :: String.t()
  def url_for_year(year) when year >= @min_year and year < @max_year do
    filename = filename_for_year(year)

    "https://www.glerl.noaa.gov/metdata/chi/archive/#{filename}"
  end

  @spec file_path_for_year(integer()) :: String.t()
  def file_path_for_year(year) when year >= @min_year and year < @max_year do
    get_data_dir() <> "/" <> filename_for_year(year)
  end

  @spec fetch_file_for_year(integer()) :: nil
  def fetch_file_for_year(year) when year >= @min_year and year < @max_year do
    :ssl.start()
    :inets.start()

    {:ok, {_status, _headers, response_content}} = :httpc.request(url_for_year(year))
    File.write(file_path_for_year(year), response_content)

    nil
  end
end
