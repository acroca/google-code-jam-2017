defmodule GcjCrTest3 do
  @p Gcj.CR.Problem3

  use ExUnit.Case
  doctest Gcj.CR.Problem3
  import Gcj.TestMacros

  test "parsing line" do
    assert @p.parseInputLine("4 2") == {4,2}
  end
  t @p, {4,2}, "1 0"
  t @p, {5,2}, "1 0"
  t @p, {6,2}, "1 1"
  t @p, {1000,1000}, "0 0"
  t @p, {1000,1}, "500 499"
  t @p, {716521,632490}, "0 0"
end
