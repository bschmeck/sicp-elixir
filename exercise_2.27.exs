defmodule DeepReverse do
  def of(list), do: of(list, [])

  defp of([], reversed), do: reversed
  defp of([head | tail], reversed) when is_list(head), do: of(tail, [of(head) | reversed])
  defp of([head | tail], reversed), do: of(tail, [head | reversed])
end

ExUnit.start

defmodule DeepReverseTests do
  use ExUnit.Case, async: true

  test "it reverses empty lists" do
    assert DeepReverse.of([]) == []
  end
  
  test "it reverses a list" do
    assert DeepReverse.of([1,2,3]) == [3,2,1]
  end

  test "it reverses nested lists" do
    assert DeepReverse.of([1, [2, 3], 4]) == [4, [3, 2], 1]
  end

  test "it reverses lists nested 3 deep" do
    assert DeepReverse.of([1, [2, [3, 4], 5], 6]) == [6, [5, [4, 3], 2], 1]
  end
end
