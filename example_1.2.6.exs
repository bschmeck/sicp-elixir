defmodule PrimeChecker do
  def is_prime?(n, :divisors) do
    n == smallest(n)
  end
  def is_prime?(n, _) do
    a = random(n)
    expmod(a, n, n) == a
  end

  def smallest(n), do: find(n, 2)

  defp find(n, test) when test * test > n, do: n
  defp find(n, test) when rem(n, test) == 0, do: test
  defp find(n, test), do: find(n, test + 1)

  defp expmod(_, 0, _), do: 1
  defp expmod(base, exp, m) when rem(exp, 2) == 0 do
    rem(square(expmod(base, div(exp, 2), m)), m)
  end
  defp expmod(base, exp, m) do
    rem(base * expmod(base, exp - 1, m), m)
  end

  defp square(n), do: n * n

  defp random(n) do
    :random.seed(:os.timestamp)
    :random.uniform * (n - 1) |> round
  end
end

ExUnit.start

defmodule PrimeCheckerTests do
  use ExUnit.Case, async: true

  test "detects prime numbers using divisors" do
    assert PrimeChecker.is_prime? 5, :divisors
    assert PrimeChecker.is_prime? 17, :divisors
    assert PrimeChecker.is_prime? 71, :divisors
  end

  test "detects non-prime numbers using divisors" do
    refute PrimeChecker.is_prime? 6, :divisors
    refute PrimeChecker.is_prime? 100, :divisors
    refute PrimeChecker.is_prime? 65536, :divisors
  end

  test "detects prime numbers using fermat" do
    assert PrimeChecker.is_prime? 5, :fermat
    assert PrimeChecker.is_prime? 17, :fermat
    assert PrimeChecker.is_prime? 71, :fermat
  end

  test "detects non-prime numbers using fermat" do
    refute PrimeChecker.is_prime? 6, :fermat
    refute PrimeChecker.is_prime? 100, :fermat
    refute PrimeChecker.is_prime? 65536, :fermat
  end
end
