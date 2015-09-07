defmodule Exercise do
  def recursive(n) when n < 3, do: n
  def recursive(n), do: recursive(n - 1) + 2 * recursive(n - 2) + 3 * recursive(n - 3)

  def iterative(n) when n < 3, do: n
  def iterative(n), do: iter_helper(0, 1, 2, n)
  def iter_helper(_, _, c, 2), do: c
  def iter_helper(a, b, c, n), do: iter_helper(b, c, 3*a + 2*b + c, n - 1)
end

ExUnit.start

defmodule ExerciseTests do
  use ExUnit.Case, async: true

  test "it returns n when n < 3" do
    assert Exercise.recursive(0) == 0
    assert Exercise.recursive(1) == 1
    assert Exercise.recursive(2) == 2

    assert Exercise.iterative(0) == 0
    assert Exercise.iterative(1) == 1
    assert Exercise.iterative(2) == 2
  end

  test "recursive and iterative impls compute the same value" do
    assert Exercise.recursive(5) == Exercise.iterative(5)
    assert Exercise.recursive(10) == Exercise.iterative(10)
    assert Exercise.recursive(12) == Exercise.iterative(12)
  end
end
