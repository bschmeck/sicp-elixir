defmodule Summation do
  def sum(term, a, next, b), do: iter(term, a, next, b, 0)

  defp iter(_, a, _, b, result) when a > b, do: result
  defp iter(term_fn, a, next_fn, b, result) do
    iter(term_fn, next_fn.(a), next_fn, b, result + term_fn.(a))
  end

  def increment(x), do: x + 1
  def cube(x), do: x * x * x
  def identity(x), do: x

  def sum_cubes(a, b), do: sum(&cube/1, a, &increment/1, b)

  def sum_ints(a, b), do: sum(&identity/1, a, &increment/1, b)

  def sum_pi(a, b) do
    term = &(1 / (&1 * (&1 + 2)))
    next = &(&1 + 4)
    sum(term, a, next, b)
  end
end

defmodule Integral do
  def of(func, a, b, dx) do
    add_dx = &(&1 + dx)
    Summation.sum(func, (a + dx / 2), add_dx, b) * dx
  end
end


ExUnit.start

defmodule SummationTests do
  use ExUnit.Case, async: true

  test "sum_cubes" do
    assert Summation.sum_cubes(1, 10) == 3025
  end

  test "sum_ints" do
   assert Summation.sum_ints(1, 10) == 55
  end

  test "sum_pi" do
    assert 8 * Summation.sum_pi(1, 1000) == 3.139592655589782
  end
end

defmodule IntegrationTests do
  use ExUnit.Case, async: true

  test "integral of x cubed from 0 to 1" do
    assert Integral.of(&Summation.cube/1, 0, 1, 0.01) == 0.24998750000000042
    assert Integral.of(&Summation.cube/1, 0, 1, 0.001) == 0.24999987500000073
  end
end
