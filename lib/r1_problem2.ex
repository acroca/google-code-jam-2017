defmodule Gcj.R1.Problem2 do
  import Gcj, only: [parse!: 1]

  def parseInput(input) do
    input
    |> Stream.drop(1)
    |> Stream.map(&parseInputLine(&1))
  end

  def parseInputLine(input) do
    parse!(input)
  end

  def process(_) do
    1
  end
end
