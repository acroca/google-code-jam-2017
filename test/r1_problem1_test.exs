defmodule GcjR1Test1 do
  @p Gcj.R1.Problem1

  use ExUnit.Case
  doctest Gcj.R1.Problem1
  import Gcj.TestMacros

  test "parsing input" do
    assert Enum.to_list(@p.parseInput(["2", "4", "2"])) == [4,2]
  end

  t @p, 1, 1
end
