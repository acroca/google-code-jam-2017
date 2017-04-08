defmodule Gcj.Autoincrement do
  def start_link do
    Agent.start_link(fn -> 1 end, name: __MODULE__)
  end

  def next() do
    Agent.get_and_update(__MODULE__, fn(state) -> {state, state + 1} end)
  end
end
defmodule Gcj.TestMacros do
  defmacro t(problem, a, b) do
    quote do
      idx = Gcj.Autoincrement.next()
      test "Problem #{to_string(unquote(problem))} - #{idx}" do
        assert unquote(problem).process(unquote(a)) == unquote(b)
      end
    end
  end
end
Gcj.Autoincrement.start_link()
ExUnit.start()
