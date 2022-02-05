defmodule DataDir do
  @spec get_data_dir() :: String.t()
  def get_data_dir() do
    "data"
  end

  @spec create_data_dir() :: String.t()
  def create_data_dir() do
    data_dir = get_data_dir()

    if not File.exists?(get_data_dir()) do
      File.mkdir!(data_dir)
    end

    data_dir
  end
end
