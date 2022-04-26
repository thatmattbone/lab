defmodule ConversionTest do
  test "meters per second to knots" do
    assert Conversion.meters_per_sec_to_knots(5.0) == 9.71922
    assert Conversion.meters_per_sec_to_knots(7.5) == 14.5788
  end
end
