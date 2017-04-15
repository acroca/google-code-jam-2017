defmodule Gcj do
  def main([probNum | _]) do
    problem = case probNum do
      "cr.1" -> Gcj.CR.Problem1
      "cr.2" -> Gcj.CR.Problem2
      "cr.3" -> Gcj.CR.Problem3
      "r1.1" -> Gcj.R1.Problem1
    end

    IO.puts IO.stream(:stdio, :line)
    |> Stream.map(&String.trim(&1))
    |> problem.parseInput()
    |> Stream.map(&problem.process(&1))
    |> Stream.with_index()
    |> Enum.map(fn ({solution, idx}) ->
      "Case ##{idx+1}: #{solution}"
    end)
    |> Enum.join("\n")
  end

  def parse!(n) when is_binary(n) do
    case Integer.parse(n) do
      {n, _} -> n
      :error -> 0
    end
  end
  def parse!(_), do: 0

end
