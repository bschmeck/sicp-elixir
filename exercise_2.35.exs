defmodule Accumulate do
  def accum(_op, init, []), do: init
  def accum(op, init, [head | tail]), do: op.(head, accum(op, init, tail))
end

defmodule CountLeaves do
  def of(list, :recurse), do: of_recurse(list)
  def of(list, :accum) do
    g = fn
      l when is_list(l) -> of(l, :accum)
      n -> 1
    end
    Accumulate.accum(&(&1 + &2), 0, Enum.map(list, g))
  end

  defp of_recurse([]), do: 0
  defp of_recurse([head | tail]), do: of_recurse(head) + of_recurse(tail)
  defp of_recurse(_), do: 1
end

ExUnit.start

defmodule CountLeavesTest do
  use ExUnit.Case, async: true

  test "it counts leaves in an empty list" do
    assert CountLeaves.of([], :recurse) == 0

    assert CountLeaves.of([], :accum) == 0
  end

  test "it count leaves in a flat list" do
    assert CountLeaves.of([1,2,3], :recurse) == 3

    assert CountLeaves.of([1,2,3], :accum) == 3
  end

  test "it count leaves in nested lists" do
    assert CountLeaves.of([[1, 2], 3], :recurse) == 3
    assert CountLeaves.of([1, [2, 3]], :recurse) == 3
    assert CountLeaves.of([[1, 2], [3, 4]], :recurse) == 4

    assert CountLeaves.of([[1, 2], 3], :accum) == 3
    assert CountLeaves.of([1, [2, 3]], :accum) == 3
    assert CountLeaves.of([[1, 2], [3, 4]], :accum) == 4
  end
end
