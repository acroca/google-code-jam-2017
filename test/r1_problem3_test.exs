defmodule GcjR1Test3 do
  @p Gcj.R1.Problem3

  use ExUnit.Case
  doctest Gcj.R1.Problem3
  import Gcj.TestMacros

  test "parsing input" do
    assert Enum.to_list(@p.parseInput(["2", "4", "2"])) == [4,2]
  end

  t @p, 1, 1
end
