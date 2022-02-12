defmodule DownloaderTest do
  use ExUnit.Case

  test "test filename from year" do
    assert ArchiveDownloader.filename_for_year(2010) == "chi2010.04t.txt"

    assert_raise FunctionClauseError, fn ->
      ArchiveDownloader.filename_for_year(1999)
    end
  end

  test "url for year" do
    assert ArchiveDownloader.url_for_year(2019) ==
             "https://www.glerl.noaa.gov/metdata/chi/archive/chi2019.04t.txt"
  end

  test "file path for year" do
    # TODO this test has side-effects. it creates the data dir in the local repo. should probably fix or isolate it somehow
    assert ArchiveDownloader.file_path_for_year(2012) == "data/chi2012.04t.txt"
  end
end
