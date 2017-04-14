defmodule GcjR1Test2 do
  @p Gcj.R1.Problem2

  use ExUnit.Case
  doctest Gcj.R1.Problem2
  import Gcj.TestMacros

  test "parsing input" do
    assert Enum.to_list(@p.parseInput(["2", "4", "2"])) == [4,2]
  end

  t @p, 1, 1
end
