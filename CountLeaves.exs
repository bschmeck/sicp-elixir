defmodule CountLeaves do
  def of([]), do: 0
  def of([head | tail]), do: of(head) + of(tail)
  def of(_), do: 1
end

ExUnit.start

defmodule CountLeavesTest do
  use ExUnit.Case, async: true

  test "it counts leaves in an empty list" do
    assert CountLeaves.of([]) == 0
  end

  test "it count leaves in a flat list" do
    assert CountLeaves.of([1,2,3]) == 3
  end

  test "it count leaves in nested lists" do
    assert CountLeaves.of([[1, 2], 3]) == 3
    assert CountLeaves.of([1, [2, 3]]) == 3
    assert CountLeaves.of([[1, 2], [3, 4]]) == 4
  end
end
