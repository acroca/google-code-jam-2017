defmodule Gcj.Problem3 do
  import Gcj, only: [parse!: 1]

  def parseInput(input) do
    input
    |> Stream.drop(1)
    |> Stream.map(&parseInputLine(&1))
  end
  def parseInputLine(input) do
    [a,b] = input
    |> String.split(" ")
    |> Enum.map(&parse!(&1))
    {a,b}
  end

  def process({bathrooms, people}) do
    s = Heap.max
    |> Heap.push({bathrooms, round(Float.floor(bathrooms/2.0))})
    |> last_bathroom(people)
    |> spots()
    |> Enum.map(&elem(&1,0))
    |> Enum.join(" ")
  end

  def last_bathroom(heap, 1) do
    Heap.root(heap)
  end

  def last_bathroom(heap, n) do
    # TODO in case of overlap, find the highest index
    heap = Heap.root(heap)
    |> spots()
    |> Enum.into(Heap.pop(heap))

    last_bathroom(heap, n-1)
  end

  @doc ~S"""
  ## Examples
      iex> Gcj.Problem3.spots {10,5}
      [{5,2},{4,8}]
      iex> Gcj.Problem3.spots {4,8}
      [{2,7},{1,9}]
      iex> Gcj.Problem3.spots {5,8}
      [{2,7},{2,10}]
      iex> Gcj.Problem3.spots {1,3}
      [{0,-1}, {0,-1}]
      iex> Gcj.Problem3.spots {2,3}
      [{1,2},{0,4}]
  """
  def spots({1,_}), do: [{0,-1}, {0,-1}]
  def spots({size,index}) do
    ls = round(Float.ceil((size-1)/2.0))
    rs = round(Float.floor((size-1)/2.0))
    li = index - round(Float.ceil(ls/2.0))
    ri = index + 1 + round(Float.floor(rs/2.0))
    [{ls, li}, {rs, ri}]
    |> Enum.filter(fn({s,_}) -> s > 0 end)
  end
end
