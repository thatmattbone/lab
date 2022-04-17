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

  test "push ring" do
    ring = Ring.new(3)

    ring = Ring.push(ring, "one")

    assert ring.current_position == 1
    assert ring.data_map == %{
      0 => "one",
      1 => nil,
      2 => nil
    }

    ring = ring
      |> Ring.push("two")
      |> Ring.push("three")
      |> Ring.push("four")

    assert ring.current_position == 1
    assert ring.data_map == %{
      0 => "four",
      1 => "two",
      2 => "three"
    }
  end

  test "to list" do
    ring = Ring.new(3)
      |> Ring.push("a")
      |> Ring.push("b")
      |> Ring.push("c")

    assert Ring.to_list(ring) == ["a", "b", "c"]

    ring = ring |> Ring.push("d") |> Ring.push("e")

    assert Ring.to_list(ring) == ["c", "d", "e"]
  end
end
