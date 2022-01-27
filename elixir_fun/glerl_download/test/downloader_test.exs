defmodule DownloaderTest do
  use ExUnit.Case

  test "test filename from year" do
    assert Downloader.filename_from_year(2010) == "chi2010.04t.txt"

    assert_raise FunctionClauseError, fn ->
      Downloader.filename_from_year(1999)
    end
  end

end
