defmodule Parity do
  def of([n | rest]), do: [n | of(n, rest)]
  defp of(_, []), do: []
  defp of(n, [head | tail]) when rem(n, 2) == rem(head, 2), do: [head | of(n, tail)]
  defp of(n, [_ | tail]), do: of(n, tail)
end

ExUnit.start

defmodule ParityTest do
  use ExUnit.Case, async: true
  test "it keeps odd numbers" do
    assert Parity.of([1, 2, 3, 4, 5, 6, 7]) == [1, 3, 5, 7]
  end

  test "it keeps even numbers" do
    assert Parity.of([2, 3, 4, 5, 6, 7]) == [2, 4, 6]
  end
end
