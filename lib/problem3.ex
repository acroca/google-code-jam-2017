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
    handle_step(data, n, gap_size, amount)
  end

  def handle_step(data, n, _, amount) when amount >= n, do: data
  def handle_step({heap, counts}, n, gap_size, amount) do
    ls = lspots(gap_size)
    rs = rspots(gap_size)

    heap = heap
    |> Heap.pop()
    |> fix_heap_based_on_lcounts(ls, Map.get(counts, ls, 0))
    |> fix_heap_based_on_rcounts(ls, rs, Map.get(counts, rs, 0))
    counts = counts 
    |> Map.delete(gap_size)
    |> Map.update(ls, amount, &(&1 + amount))
    |> Map.update(rs, amount, &(&1 + amount))

    last_bathroom({
      heap,
      counts
    }, n - amount)
  end
  def fix_heap_based_on_lcounts(heap, ls, 0) do
    Heap.push(heap, ls)
  end
  def fix_heap_based_on_lcounts(heap, _, _), do: heap

  def fix_heap_based_on_rcounts(heap, a, a, _), do: heap
  def fix_heap_based_on_rcounts(heap, _, rs, 0) do
    Heap.push(heap, rs)
  end
  def fix_heap_based_on_rcounts(heap, _, _, _), do: heap

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
