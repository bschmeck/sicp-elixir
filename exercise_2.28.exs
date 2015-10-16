defmodule Fringe do
  def of([]), do: []
  def of([head | tail]) when is_list(head), do: of(head) ++ of(tail)
  def of([head | tail]), do: [ head | of(tail) ]
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
