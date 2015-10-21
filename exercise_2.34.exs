defmodule Accumulate do
  def accum(_op, init, []), do: init
  def accum(op, init, [head | tail]), do: op.(head, accum(op, init, tail))
end

defmodule HornersRule do
  def run(x, coefficients) do
    f = fn(coeff, higher_terms) -> coeff + x * higher_terms end
    Accumulate.accum(f, 0, coefficients)
  end
end

ExUnit.start

defmodule HornersRuleTest do
  use ExUnit.Case, async: true

  test "it evaluates polynomials" do
    coeffs = [1, 3, 0, 5, 0, 1]
    assert HornersRule.run(2, coeffs) == 79
  end
end
