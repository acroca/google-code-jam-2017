defmodule Gcj.Problem1 do
  import Gcj, only: [parse!: 1]

  def parseInput(input) do
    input
    |> Stream.drop(1)
    |> Stream.map(&parseInputLine(&1))
  end

  def parseInputLine(input) do
    [seq | [n|_]] = String.split(input, " ")
    {parse!(n), seq}
  end

  def process({n, seq}) do
    case count(n, seq) do
      :err -> "IMPOSSIBLE"
      n -> n
    end
  end

  def count(n, s) when byte_size(s)<n do
    :err
  end
  def count(n, "-" <> _ = s) when byte_size(s)==n do
    case count(n, flip(s, n)) do
      :err -> :err
      0 -> 1
    end
  end
  def count(n, s) when byte_size(s)==n do
    if all_up(s) do
      0
    else
      :err
    end
  end
  def count(n, "+" <> rest) do
    count(n, rest)
  end
  def count(n, "-" <> rest) do
    case count(n, flip(rest, n-1)) do
      :err -> :err
      n -> n+1
    end
  end

  def all_up("+" <> rest), do: all_up(rest)
  def all_up("-" <> _), do: false
  def all_up(""), do: true

  def flip("", _), do: ""
  def flip(s, 0), do: s
  def flip("+" <> rest, n), do: "-"<>flip(rest, n-1)
  def flip("-" <> rest, n), do: "+"<>flip(rest, n-1)
end
