defmodule Accumulate do
  def accum(_op, init, []), do: init
  def accum(op, init, [head | tail]), do: op.(head, accum(op, init, tail))
end

ExUnit.start

defmodule ListManipulations do
  use ExUnit.Case, async: true

  test "implementing map" do
    map = fn(p, sequence) -> Accumulate.accum(&([p.(&1) | &2]), [], sequence) end
    assert map.(&(&1 * &1), [1, 2, 3, 4]) == [1, 4, 9, 16]
  end

  test "implementing append" do
    append = fn(seq1, seq2) -> Accumulate.accum(&([&1 | &2]), seq2, seq1) end
    assert append.([1, 2, 3], [4, 5, 6]) == [1, 2, 3, 4, 5, 6]
  end

  test "implementing length" do
    length = fn(sequence) -> Accumulate.accum(fn(_, tot) -> tot + 1 end, 0, sequence) end
    assert length.([1, 2, 3, 4, 5]) == 5
  end
end

defmodule AccumulateTest do
  use ExUnit.Case, async: true

  test "it accumulates via addition" do
    assert Accumulate.accum(&(&1 + &2), 0, [1, 2, 3, 4, 5]) == 15
  end

  test "it accumulates via multiplication" do
    assert Accumulate.accum(&(&1 * &2), 1, [1, 2, 3, 4, 5]) == 120
  end

  test "it accumulates via cons" do
    assert Accumulate.accum(&([&1 | &2]), [], [1, 2, 3, 4, 5]) == [1, 2, 3, 4, 5]
  end
end
