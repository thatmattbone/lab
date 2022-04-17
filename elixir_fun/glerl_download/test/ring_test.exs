defmodule RingTest do
  use ExUnit.Case

  test "new ring" do
    ring = Ring.new(5)

    assert ring.current_position == 0
    assert ring.length == 5
    assert ring.data_map == %{
      0 => nil,
      1 => nil,
      2 => nil,
      3 => nil,
      4 => nil
    }
  end
end
