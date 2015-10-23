defmodule Accumulate do
  def accum(_op, init, []), do: init
  def accum(op, init, [head | tail]), do: op.(head, accum(op, init, tail))

  def accum_n(_op, _init, [ [] | _tail]), do: []
  def accum_n(op, init, list) do
    heads = Enum.map(list, &(hd &1))
    tails = Enum.map(list, &(tl &1))
    [ accum(op, init, heads) | accum_n(op, init, tails) ]
  end
end

ExUnit.start

defmodule AccumulateTests do
  use ExUnit.Case, async: true

  test "it accumulates multiple sequences" do
    sequences = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [10, 11, 12]]
    assert Accumulate.accum_n(&(&1 + &2), 0, sequences) == [22, 26, 30]
  end
end

