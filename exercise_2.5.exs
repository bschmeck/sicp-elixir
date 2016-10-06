defmodule MathCons do
  def cons(a, b), do: round(:math.pow(2, a) * :math.pow(3, b))

  def car(z), do: div_count(z, 2, 0)
  def cdr(z), do: div_count(z, 3, 0)

  defp div_count(z, r, i) when rem(z, r) != 0, do: i
  defp div_count(z, r, i), do: div_count(div(z, r), r, i + 1)
  
  #defp car_iter(z, i) when rem(z, 2) != 0, do: i
  #defp car_iter(z, i), do: car_iter(div(z, 2), i + 1)

  #defp cdr_iter(z, i) when rem(z, 3) != 0, do: i
  #defp cdr_iter(z, i), do: cdr_iter(div(z, 3), i + 1)
end

ExUnit.start

defmodule MathConsTest do
  use ExUnit.Case, async: true

  test "car returns the first element of the cons" do
    z = MathCons.cons 4, 9
    assert MathCons.car(z) == 4
  end
  
  test "car handles 0" do
    z = MathCons.cons 0, 9
    assert MathCons.car(z) == 0
  end
  
  test "cdr returns the last element of the cons" do
    z = MathCons.cons 4, 9
    assert MathCons.cdr(z) == 9
  end

  test "cdr handles 0" do
    z = MathCons.cons 4, 0
    assert MathCons.cdr(z) == 0
  end
end
