defmodule Fold do
  def right(_op, init, []), do: init
  def right(op, init, [head | tail]), do: op.(head, right(op, init, tail))

  def left(op, init, sequence) do
    iter = fn
      (_this, result, []) -> result
      (this, result, [head | tail]) -> this.(this, op.(result, head), tail)
    end
    iter.(iter, init, sequence)
  end
end

ExUnit.start

defmodule FoldTests do
  use ExUnit.Case, async: true

  test "it folds division right" do
    assert Fold.right(&(&1 / &2), 1, [1, 2, 3]) == 3 / 1 / 2 / 1
  end

  test "it folds division left" do
    assert Fold.left(&(&1 / &2), 1, [1, 2, 3]) == 1 / 2 / 3
  end

  test "it folds lists right" do
    assert Fold.right(&([&1, &2]), [], [1, 2, 3]) == [1, [2, [3, []]]]
  end

  test "it folds lists left" do
    assert Fold.left(&([&1, &2]), [], [1, 2, 3]) == [[[[], 1], 2], 3]
  end
end
