defmodule Gcj.R1A.Problem1 do
  import Gcj, only: [parse!: 1]

  def parseInput(input) do
    input
    |> Stream.drop(1)
    |> Enum.to_list()
    |> parseAllExercises([])
  end

  def parseAllExercises(input, acc) do
    first_line = input
    |> Stream.take(1)
    |> Enum.to_list()
    |> Enum.flat_map(&String.split(&1, " "))
    |> Enum.map(&parse!/1)
    input = Stream.drop(input, 1)
    case first_line do
      [c,_] ->
        lines = parseCake(Enum.to_list(Stream.take(input, c)))
        input = Stream.drop(input, c)
        parseAllExercises(input,acc ++ [lines])
      _ -> acc
    end
  end

  def parseCake(lines) do
    lines
    |> Enum.map(fn line ->
      line
      |> String.codepoints
    end)
  end

  def process(cake) do
    res = cake
    |> Enum.map(&fill_line(&1,nil))
    |> fill_empty_lines(nil)
    |> Enum.join("\n")
    "\n" <> res
  end


  @doc ~S"""
  ## Examples
      iex> Gcj.R1A.Problem1.fill_line ~w(? ? ?), nil
      ~w(? ? ?)
      iex> Gcj.R1A.Problem1.fill_line ~w(? ? ? A), nil
      ~w(A A A A)
      iex> Gcj.R1A.Problem1.fill_line ~w(? ? ? A ?), nil
      ~w(A A A A A)
      iex> Gcj.R1A.Problem1.fill_line ~w(? ? ? A ? B), nil
      ~w(A A A A A B)
      iex> Gcj.R1A.Problem1.fill_line ~w(? ? ? A ? B ?), nil
      ~w(A A A A A B B)
  """

  def fill_line(line, nil), do: fill_line(line, first_letter(line))
  def fill_line(line, "?"), do: line
  def fill_line([], _), do: []
  def fill_line(["?"|rest], replace) do
    [replace | fill_line(rest, replace)]
  end
  def fill_line([v|rest], replace) do
    [v | fill_line(rest, v)]
  end

  @doc ~S"""
  ## Examples
      iex> Gcj.R1A.Problem1.first_letter ~w()
      "?"
      iex> Gcj.R1A.Problem1.first_letter ~w(? ?)
      "?"
      iex> Gcj.R1A.Problem1.first_letter ~w(? ? A)
      "A"
      iex> Gcj.R1A.Problem1.first_letter ~w(? ? A B)
      "A"
  """
  def first_letter([]), do: "?"
  def first_letter(["?"|rest]), do: first_letter(rest)
  def first_letter([v|rest]), do: v

  @doc ~S"""
  ## Examples
      iex> Gcj.R1A.Problem1.fill_empty_lines [~w()], nil
      [~w()]
      iex> Gcj.R1A.Problem1.fill_empty_lines [~w(? ?), ~w(A B)], nil
      [~w(A B), ~w(A B)]
      iex> Gcj.R1A.Problem1.fill_empty_lines [~w(? ?), ~w(A B), ~w(? ?)], nil
      [~w(A B), ~w(A B), ~w(A B)]
      iex> Gcj.R1A.Problem1.fill_empty_lines [~w(? ?), ~w(A B), ~w(C D)], nil
      [~w(A B), ~w(A B), ~w(C D)]
      iex> Gcj.R1A.Problem1.fill_empty_lines [~w(? ?), ~w(A B), ~w(? ?), ~w(C D), ~w(? ?)], nil
      [~w(A B), ~w(A B), ~w(A B), ~w(C D), ~w(C D)]
  """


  def fill_empty_lines(lines, nil), do: fill_empty_lines(lines, first_filled_line(lines))
  def fill_empty_lines([], _), do: []
  def fill_empty_lines([["?"|_]|rest], line), do: [line|fill_empty_lines(rest, line)]
  def fill_empty_lines([line|rest], _), do: [line|fill_empty_lines(rest, line)]

  def first_filled_line([line|rest]) do
    if Enum.at(line,0) == "?" do
      first_filled_line(rest)
    else
      line
    end    
  end
end
