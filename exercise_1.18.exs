defmodule Multiplication do
  def mult(0, _), do: 0
  def mult(_, 0), do: 0
  def mult(a, b), do: iter(0, a, b)

  def iter(total, a, 1), do: total + a
  def iter(total, a, b) when rem(b, 2) == 0 do
    iter(total, double(a), halve(b))
  end
  def iter(total, a, b) do
    iter(total + a, a, b - 1)
  end

  defp double(a), do: 2 * a
  defp halve(a), do: div(a, 2)
end
