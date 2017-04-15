defmodule GcjR1Test1 do
  @p Gcj.R1.Problem1

  use ExUnit.Case
  doctest Gcj.R1.Problem1
  import Gcj.TestMacros

  test "parsing input" do
    assert Enum.to_list(@p.parseInput([
      "3",
      "3 3",
      "G??",
      "?C?",
      "??J",
      "3 4",
      "CODE",
      "????",
      "?JAM",
      "2 2",
      "CA",
      "KE"])) == [
        [ ~w(G ? ?), ~w(? C ?), ~w(? ? J) ],
        [ ~w(C O D E), ~w(? ? ? ?), ~w(? J A M) ],
        [ ~w(C A), ~w(K E) ]
      ]
  end

  t @p, [ ~w(G ? ?), ~w(? C ?), ~w(? ? J) ], [ ~w(G G G), ~w(C C C), ~w(J J J) ]
  t @p, [ ~w(G C J), ~w(? ? ?), ~w(? ? ?) ], [ ~w(G C J), ~w(G C J), ~w(G C J) ]
  t @p, [ ~w(? ? ?), ~w(? ? ?), ~w(G C J) ], [ ~w(G C J), ~w(G C J), ~w(G C J) ]
end
