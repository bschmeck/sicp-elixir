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
    { elapsed, result } = :timer.tc(fn -> is_prime?(n, 10) end)
    if result do
      IO.puts " *** "
      IO.puts "Checking took #{elapsed} milliseconds"
    end
    result
  end
  def is_prime?(_, 0), do: true
  def is_prime?(n, tries) do
    a = random(n)
    if expmod(a, n, n) == a do
      is_prime? n, tries - 1
    else
      false
    end
  end

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

PrimeTime.search_for(3, 1_000)
IO.puts " ======== "
PrimeTime.search_for(3, 10_000)
IO.puts " ======== "
PrimeTime.search_for(3, 100_000)
IO.puts " ======== "
PrimeTime.search_for(3, 1_000_000)
IO.puts " ======== "

# Results:
# 1009 -> 26 ms
# 1013 -> 27 ms
# 1019 -> 26 ms
#
# 10007 -> 30 ms
# 10009 -> 31 ms
# 10037 -> 45 ms
#
# 10003 -> 40 ms
# 10019 -> 44 ms
# 10043 -> 45 ms
#
# 100003 -> 46 ms
# 100033 -> 43 ms
# 100037 -> 45 ms

# Growth:
#   1000 ->   10000 = 1.15x
#  10000 ->  100000 = 1.13x
# 100000 -> 1000000 = 1.12x
#
# sqrt(10) =~ 3.16 

