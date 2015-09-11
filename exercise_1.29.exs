defmodule Summation do
  def sum(_, a, _, b) when a > b, do: 0
  def sum(term_fn, a, next_fn, b) do
    term_fn.(a) + sum(term_fn, next_fn.(a), next_fn, b)
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

  def simpsons(func, a, b, n) do
    # Sum from 0 to n of:
    # 1y0 + 4y1 + 2y2 + 4y3 + 2y4 + ... + 1yn
    h = (b - a) / n
    coeff = fn
      0 -> 1
      k when k == n -> 1
      k when rem(k, 2) == 0 -> 2
      _ -> 4
    end
    y = &(func.(a + &1 * h))
    term = fn k -> coeff.(k) * y.(k) end
    (h / 3) * Summation.sum(term, 0, &Summation.increment/1, n)
  end
end

IO.puts "Integral of cube from 0 to 1"
IO.puts "Numerically,  dx = 0.01: #{Integral.of(&Summation.cube/1, 0, 1, 0.01)}"
IO.puts "Simpson's Rule, n = 100: #{Integral.simpsons(&Summation.cube/1, 0, 1, 100)}"
IO.puts "Numerically,  dx = 0.001: #{Integral.of(&Summation.cube/1, 0, 1, 0.001)}"
IO.puts "Simpson's Rule, n = 1000: #{Integral.simpsons(&Summation.cube/1, 0, 1, 1000)}"
