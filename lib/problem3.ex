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
    last = {
      Heap.max |> Heap.push(bathrooms), # For next larger gap
      Map.new |> Map.put(bathrooms, 1) # For counts
    }
    |> last_bathroom(people)
    |> elem(0)
    |> Heap.root()
    "#{lspots(last)} #{rspots(last)}"
  end

  def last_bathroom(data, 0) do
    data
  end

  def last_bathroom({heap, counts} = data, n) do
    gap_size = Heap.root(heap)
    amount = Map.get(counts, gap_size)
    if amount < n do
      heap = Heap.pop(heap)
      counts = Map.delete(counts, gap_size)
      ls = lspots(gap_size)
      rs = rspots(gap_size)
      if (Map.get(counts, ls, 0) == 0) do
        heap = Heap.push(heap, ls)
      end
      if rs != ls && Map.get(counts, rs, 0) == 0 do
        heap = Heap.push(heap, rs)
      end
      counts = Map.update(counts, ls, amount, &(&1 + amount))
      counts = Map.update(counts, rs, amount, &(&1 + amount))

      last_bathroom({
        heap,
        counts
      }, n - amount)
    else
      data
    end
  end

  def reprocess_heap(heap) do
    heap
    |> Enum.reduce([], fn(v,acc) ->
      acc ++ [lspots(v), rspots(v)]
    end)
    |> Enum.into(Heap.max)
  end

  @doc ~S"""
  ## Examples
      iex> Gcj.Problem3.lspots 10
      5
      iex> Gcj.Problem3.lspots 4
      2
      iex> Gcj.Problem3.lspots 5
      2
      iex> Gcj.Problem3.lspots 1
      0
      iex> Gcj.Problem3.lspots 2
      1
  """
  def lspots(1), do: 0
  def lspots(size), do: round(Float.ceil((size-1)/2.0))
  @doc ~S"""
  ## Examples
      iex> Gcj.Problem3.rspots 10
      4
      iex> Gcj.Problem3.rspots 4
      1
      iex> Gcj.Problem3.rspots 5
      2
      iex> Gcj.Problem3.rspots 1
      0
      iex> Gcj.Problem3.rspots 2
      0
  """
  def rspots(1), do: 0
  def rspots(size), do: round(Float.floor((size-1)/2.0))
end
