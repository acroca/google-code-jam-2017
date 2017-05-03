defmodule Gcj.R1C.Problem1 do
  @pi 3.141592653589793238462643
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
      [n,k] ->
        pancakes = input
        |> Stream.take(n)
        |> Enum.map(fn line ->
          line 
          |> String.split(" ")
          |> Enum.map(&parse!/1)
          |> List.to_tuple()
        end)
        input = Stream.drop(input, n)
        parseAllExercises(input,acc ++ [{n,k,pancakes}])
      _ -> acc
    end
  end

  def process({n,k,pancakes}) do
    pancakes = pancakes |> Enum.map(&add_areas/1)
    sorted_by_radial_area = pancakes |> reverse_sort_by_elem(3)

    selected = sorted_by_radial_area |> Enum.take(k-1)
    max_surface = selected |> Enum.map(&elem(&1,2)) |> enum_max()
    selected_radial_area = selected |> Enum.map(&elem(&1,3)) |> Enum.sum()

    remaining = sorted_by_radial_area |> Enum.slice(k-1..n-1)
    with_added_value = remaining |> Enum.map(&add_added_value(&1,max_surface))
    best_candidate = with_added_value |> reverse_sort_by_elem(1) |> List.first() |> elem(0)

    max_surface = max(max_surface, elem(best_candidate,2))
    sum_lateral = selected_radial_area + elem(best_candidate,3)

    Float.round(@pi * (max_surface + sum_lateral), 7)
  end

  def add_areas({r,h}) do
    {r,h,r*r,2*r*h}
  end

  def add_added_value({_,_,a,l}=element, a_largest) do
    {element, l + max(0,a - a_largest)}
  end

  def reverse_sort_by_elem(arr, idx) do
    arr |> Enum.sort_by(fn e ->
      1 - elem(e,idx)
    end)
  end
  def enum_max([]), do: 0
  def enum_max(a), do: Enum.max(a)
end
