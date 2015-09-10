defmodule PrimeTime do
  def search_for(0, _), do: :ok
  def search_for(n_primes, minimum) when rem(minimum, 2) == 0, do: search_for(n_primes, minimum + 1)
  def search_for(n_primes, minimum) do
    result = timed_prime_test(minimum)
    if result do
      n_primes = n_primes - 1
    end
    search_for(n_primes, minimum + 2)
  end

  def timed_prime_test(n) do
    IO.puts n
    { elapsed, result } = :timer.tc(fn -> is_prime?(n) end)
    if result do
      IO.puts " *** "
      IO.puts "Checking took #{elapsed} milliseconds"
    end
    result
  end
  def is_prime?(n) do
    n == smallest(n)
  end

  def smallest(n), do: find(n, 2)

  defp find(n, test) when test * test > n, do: n
  defp find(n, test) when rem(n, test) == 0, do: test
  defp find(n, test), do: find(n, test + 1)
end

PrimeTime.search_for(3, 1_000)
IO.puts " ======== "
PrimeTime.search_for(3, 10_000)
IO.puts " ======== "
PrimeTime.search_for(3, 100_000)
IO.puts " ======== "
PrimeTime.search_for(3, 1_000_000)
IO.puts " ======== "

# Results:
# 1009 -> 2 ms
# 1013 -> 2 ms
# 1019 -> 2 ms
#
# 10007 -> 5 ms
# 10009 -> 5 ms
# 10037 -> 5 ms
#
# 10003 -> 15 ms
# 10019 -> 26 ms
# 10043 -> 16 ms
#
# 100003 -> 47 ms
# 100033 -> 46 ms
# 100037 -> 46 ms

# Growth:
#   1000 ->   10000 = 2.5x
#  10000 ->  100000 = 3.8x
# 100000 -> 1000000 = 2.4x
#
# sqrt(10) =~ 3.16 

