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

defmodule Reverse do
  def right(sequence) do
    f = fn(x, y) ->
      y ++ [x]
    end
    Fold.right(f, [], sequence)
  end

  def left(sequence) do
    f = fn(x, y) -> [y | x] end
    Fold.left(f, [], sequence)
  end
end

ExUnit.start

defmodule ReverseTests do
  use ExUnit.Case, async: true

  test "it reverses lists via Fold.right" do
    assert Reverse.right([1, 2, 3]) == [3, 2, 1]
  end

  test "it reverses lists via Fold.left" do
    assert Reverse.left([1, 2, 3]) == [3, 2, 1]
  end
end
