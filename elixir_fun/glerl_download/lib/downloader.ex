defmodule  Downloader do

  def get_data_dir() do
    "data"
  end

  def create_data_dir() do
    if not File.exists?(get_data_dir()) do
      File.mkdir!(get_data_dir())
    end
  end
end
