defmodule SquareTree do
  def run([]), do: []
  def run([head | tail]), do: [run(head) | run(tail)]
  def run(elt), do: elt * elt

  def run_map(tree) do
    square = fn
      l when is_list(l) -> run_map(l)
      n -> n * n
    end
    Enum.map(tree, square)
  end
end

ExUnit.start

defmodule SquareTreeTests do
  use ExUnit.Case, async: true

  test "it squares all elements in a tree" do
    tree = [1, [2, [3, 4], 5], [6, 7]]
    expected = [1, [4, [9, 16], 25], [36, 49]]
    assert SquareTree.run(tree) == expected
  end

  test "it squares all elements in a tree via map" do
    tree = [1, [2, [3, 4], 5], [6, 7]]
    expected = [1, [4, [9, 16], 25], [36, 49]]
    assert SquareTree.run_map(tree) == expected
  end
end
