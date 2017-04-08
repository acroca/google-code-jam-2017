defmodule GcjTest1 do
  @p Gcj.Problem1

  use ExUnit.Case
  doctest Gcj.Problem1
  import Gcj.TestMacros

  t @p, {3, "---+-++-"}, 3
  t @p, {4, "+++++"}, 0
  t @p, {4, "-+-+-"}, "IMPOSSIBLE"
end
