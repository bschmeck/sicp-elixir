defmodule Exponential do
  def of(_, 0), do: 1
  def of(b, n), do: iter(1.0, b, n)
  def iter(a, b, 1), do: a * b
  def iter(a, b, n) when rem(n, 2) == 0 do
    iter(a, b * b, div(n, 2))
  end
  def iter(a, b, n) do
    iter(a * b, b, n - 1)
  end
end

# (5, 7)
# (1, 5, 7)
# (5, 5, 6)
# (125, 5, 3)
# (625, 5, 2)
# (625 * 25, 5, 1)

ExUnit.start

defmodule ExponentialTest do
  use ExUnit.Case, async: true

  test "correctly raises a number to an even exponent" do
    assert Exponential.of(5, 4) == :math.pow(5, 4)
  end

  test "correctly raises a number to an odd exponent" do
    assert Exponential.of(5, 5) == :math.pow(5, 5)
  end

  test "correctly raises a number to an exponent of 1" do
    assert Exponential.of(5, 1) == :math.pow(5, 1)
  end

  test "correctly raises a number to an exponent of 0" do
    assert Exponential.of(5, 0) == :math.pow(5, 0)
  end
end