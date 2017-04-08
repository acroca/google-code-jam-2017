defmodule Gcj.Problem4 do
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
    1
  end
end
