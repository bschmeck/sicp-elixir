defmodule Fibonacci do
  def of(n), do: iter(1, 0, 0, 1, n)

  defp iter(_, b, _, _, 0), do: b
  
  defp iter(a, b, p, q, count) when rem(count, 2) == 0 do
    p_prime = p * p + q * q
    q_prime = 2 * p * q + q * q
    iter(a, b, p_prime, q_prime, div(count, 2))
  end

  defp iter(a, b, p, q, count) do
    new_a = b * q + a * q + a * p
    new_b = b * p + a * q
    iter(new_a, new_b, p, q, count - 1)
  end
end

ExUnit.start

defmodule FibonacciTest do
  use ExUnit.Case, async: true

  test "computes correctly" do
    assert Fibonacci.of(0) == 0
    assert Fibonacci.of(1) == 1
    assert Fibonacci.of(2) == 1
    assert Fibonacci.of(3) == 2
    assert Fibonacci.of(4) == 3
    assert Fibonacci.of(5) == 5
    assert Fibonacci.of(19) == 4181
  end
end
