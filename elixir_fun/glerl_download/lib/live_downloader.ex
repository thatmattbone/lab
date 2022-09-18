defmodule LiveDownloader do
  # https://www.glerl.noaa.gov/metdata/chi/2022/20220909.04t.txt

  @spec get_todays_file_url() :: String.t()
  def get_todays_file_url() do

    {:ok, now_utc} = DateTime.now("UTC")
    now_str = Calendar.strftime(now_utc, "%Y%m%d")

    "https://www.glerl.noaa.gov/metdata/chi/2022/#{now_str}.04t.txt"
  end
end
