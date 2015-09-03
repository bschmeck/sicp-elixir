defmodule Multiplication do
  def slow_mult(_, 0), do: 0
  def slow_mult(a, b) do
    a + slow_mult(a, b - 1)
  end


  def mult(_, 0), do: 0
  def mult(a, b) when rem(b, 2) == 0, do: mult(double(a), halve(b))
  def mult(a, b), do: a + mult(a, b - 1)

  defp double(a), do: 2 * a
  defp halve(a), do: div(a, 2)
end
