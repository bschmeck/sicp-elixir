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


ExUnit.start

defmodule MultiplicationTests do
  use ExUnit.Case, async: true

  test "it multiplies by 0" do
    assert Multiplication.mult(5, 0) == 0
    assert Multiplication.mult(0, 12) == 0
    assert Multiplication.mult(0, 0) == 0
  end

  test "it multplies numbers" do
    assert Multiplication.mult(5, 5) == 25
    assert Multiplication.mult(4, 7) == 28
    assert Multiplication.mult(7, 14) == 98
    assert Multiplication.mult(8, 8) == 64
  end
end
