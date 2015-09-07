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
