defmodule Fringe do
  def of(tree), do: reverse(of(tree, []))
  
  defp of([], fringe), do: fringe
  defp of([head | tail], fringe) when is_list(head), do: of(tail, of(head, fringe))
  defp of([head | tail], fringe), do: of(tail, [head | fringe])

  defp reverse(items), do: reverse(items, [])
  defp reverse([], reversed), do: reversed
  defp reverse([head | tail], reversed), do: reverse(tail, [head | reversed])
end

ExUnit.start

defmodule FringeTests do
  use ExUnit.Case, async: true

  test "w/o nesting, it returns the list" do
    assert Fringe.of([1,2,3,4]) == [1,2,3,4]
  end

  test "w/ nesting, it flattens the list" do
    assert Fringe.of([1, [2, 3], 4]) == [1,2,3,4]
  end
end
