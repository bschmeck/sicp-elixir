defmodule Permutations do
  def of([]), do: [[]]
  def of(set) do
    Enum.flat_map(set, fn(x) ->
      subset = of(List.delete(set, x))
      Enum.map(subset, fn(p) -> [x | p] end)
    end)
  end
end

ExUnit.start

defmodule PermutationTests do
  use ExUnit.Case, async: false

  test "permutations of an empty list is an empty list" do
    assert Permutations.of([]) == [[]]
  end

  test "permutations of a single item list is the item" do
    assert Permutations.of([1]) == [[1]]
  end
  
  test "it computes permutations" do
     assert Permutations.of([1, 2, 3]) == [[1, 2, 3], [1, 3, 2], [2, 1, 3], [2, 3, 1], [3, 1, 2], [3, 2, 1]]
  end
end

               
