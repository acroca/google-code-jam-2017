defmodule GcjTest2 do
  @p Gcj.Problem2

  use ExUnit.Case
  doctest Gcj.Problem2
  import Gcj.TestMacros

  t @p, [1,3,2], "129"
  t @p, [1,0,0,0], "999"
  t @p, [7], "7"
  t @p, [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0], "99999999999999999"
end
