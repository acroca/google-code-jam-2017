defmodule Gcj do
  def main([probNum | _]) do
    problem = case probNum do
      "1" -> Gcj.Problem1
      "2" -> Gcj.Problem2
      "3" -> Gcj.Problem3
      "4" -> Gcj.Problem4
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
