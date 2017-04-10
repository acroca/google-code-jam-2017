defmodule Gcj.Problem2 do
  import Gcj, only: [parse!: 1]

  def parseInput(input) do
    input
    |> Stream.drop(1)
    |> Stream.map(&parseInputLine(&1))
  end
  def parseInputLine(input) do
    input
    |> String.codepoints()
    |> Enum.map(&parse!(&1))
  end
  # def parseInputLine([_ | [line | _]]) do
  #   String.split(line, " ")
  #   |> Enum.map(&parse!(&1))
  # end

  def process(n) do
    tidy({Enum.reverse(n), []})
    |> elem(1)
    |> Enum.map(&Integer.to_string(&1))
    |> Enum.join()
  end

  def tidy({[], acc}), do: {[], acc}
  def tidy({[0|[]], acc}) do
    {[], acc}
  end
  def tidy({[a|[]], acc}) do
    {[], [a|acc]}
  end
  def tidy({[b|[a|rest]], acc}) when a <= b do
    tidy({[a|rest], [b|acc]})
  end
  def tidy({[b|[a|rest]], acc}) when a > b do
    nines = Enum.map([b|acc], fn (_) -> 9 end)
    tidy({[a-1|rest], nines})
  end

end
