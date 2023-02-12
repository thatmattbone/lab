defmodule DictionaryTest do
  use ExUnit.Case

  test "my list len, empty" do
    assert MyLists.len([]) == 0
  end

  test "my list len" do
    assert MyLists.len([1, 2]) == 2
  end

  test "my list sum" do
    assert MyLists.sum([4, 5, 6]) == 15
  end

  test "my list map" do
    assert MyLists.map([1, 2, 3], fn (_x) -> "A" end) == ["A", "A", "A"]
  end
end
