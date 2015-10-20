defmodule Subsets do
  def of([]), do: [[]]
  def of([head | tail]) do
    rest = of(tail)
    rest ++ Enum.map(rest, &([head | &1]))
  end
end

ExUnit.start

defmodule SubsetsTests do
  use ExUnit.Case, async: true

  test "subsets of an empty set is just an empty set" do
    assert Subsets.of([]) == [[]]
  end

  test "subset of an single element set is empty set plus 1 elt set" do
    assert Subsets.of([1]) == [[], [1]]
  end

  test "subsets of a 3 element set" do
    set = [1, 2, 3]
    subsets = [[], [3], [2], [2, 3], [1], [1, 3], [1, 2], [1, 2, 3]]
    assert Subsets.of(set) == subsets
  end
end
