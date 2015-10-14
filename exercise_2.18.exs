defmodule Reverse do
  def of(list), do: of(list, [])

  defp of([], reversed), do: reversed
  defp of([head | tail], reversed), do: of(tail, [head | reversed])
end

ExUnit.start

defmodule ReverseTest do
  use ExUnit.Case, async: true
  
  test "it reverses empty lists" do
    assert Reverse.of([]) == []
  end

  test "it reverses one element lists" do
    assert Reverse.of([1]) == [1]
  end

  test "it reverses lists of many elements" do
    assert Reverse.of([1, 4, 9, 16, 25]) == [25, 16, 9, 4, 1]
  end
end
