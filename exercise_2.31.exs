defmodule TreeMap do
  def map(_f, []), do: []
  def map(f, [head | tail]), do: [map(f, head) | map(f, tail)]
  def map(f, elt), do: f.(elt)
end

defmodule SquareTree do
  def run(tree), do: TreeMap.map(&(&1 * &1), tree)
end

ExUnit.start

defmodule SquareTreeTests do
  use ExUnit.Case, async: true

  test "it squares all elements in a tree" do
    tree = [1, [2, [3, 4], 5], [6, 7]]
    expected = [1, [4, [9, 16], 25], [36, 49]]
    assert SquareTree.run(tree) == expected
  end
end
