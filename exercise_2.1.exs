defmodule Rational do
  def make(n, d) when d < 0, do: make(-n, -d)
  def make(n, d) do
    g = gcd(abs(n), abs(d))
    [div(n, g) | div(d, g)]
  end
  def numer(rat), do: hd(rat)
  def denom(rat), do: tl(rat)

  def string(rat), do: "#{Rational.numer rat} / #{Rational.denom rat}"
  def print(rat), do: IO.puts string(rat)

  defp gcd(a, 0), do: a
  defp gcd(a, b), do: gcd(b, rem(a, b))
end

ExUnit.start

defmodule RationalTests do
  use ExUnit.Case, async: true

  test "it reduces a positive numerator and positive denominator" do
    assert Rational.make(3, 6) == Rational.make(1, 2)
  end
  test "it reduces a positive numerator and negative denominator" do
    assert Rational.make(3, -6) == Rational.make(-1, 2)
  end
  test "it reduces a negative numerator and positive denominator" do
    assert Rational.make(-3, 6) == Rational.make(-1, 2)
  end
  test "it reduces a negative numerator and negative denominator" do
    assert Rational.make(-3, -6) == Rational.make(1, 2)
  end
end
