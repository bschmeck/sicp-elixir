defmodule Exercise do
  def recursive(n) when n < 3, do: n
  def recursive(n), do: recursive(n - 1) + 2 * recursive(n - 2) + 3 * recursive(n - 3)

  def iterative(n) when n < 3, do: n
  def iterative(n), do: iter_helper(0, 1, 2, n)
  def iter_helper(_, _, c, 2), do: c
  def iter_helper(a, b, c, n), do: iter_helper(b, c, 3*a + 2*b + c, n - 1)
end
