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
  defp find(n, test) when test == 2, do: find(n, test + 1)
  defp find(n, test), do: find(n, test + 2)
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
# 1009 -> 1 ms
# 1013 -> 2 ms
# 1019 -> 1 ms
#
# 10007 -> 3 ms
# 10009 -> 3 ms
# 10037 -> 3 ms
#
# 10003 -> 9 ms
# 10019 -> 9 ms
# 10043 -> 9 ms
#
# 100003 -> 27 ms
# 100033 -> 28 ms
# 100037 -> 27 ms

# Speedup
#    1000: 2 ms -> 1.33 ms (1.5x)
#   10000: 5 ms -> 3 ms (1.66x)
#  100000: 19 ms -> 9 ms (2.11x)
# 1000000: 46.33 ms -> 27.33 ms (1.69x) 
#
# sqrt(10) =~ 3.16 

