defmodule UniquePairs do
  def of(n) when n < 2, do: []
  
  def of(n) do
    Enum.flat_map(2..n, fn(i) ->
      Enum.map(1..(i-1), fn(j) -> [i, j] end)
    end)
  end
end

defmodule PrimeSumPairs do
  def of(n) when n < 2, do: []

  def of(n) do
    Enum.filter(UniquePairs.of(n), &prime_sum?/1)
  end

  defp prime_sum?(pair) do
    i = hd pair
    j = hd tl pair
    PrimeChecker.is_prime?(i + j)
  end
end

defmodule PrimeChecker do
  def is_prime?(n), do: n == smallest(n)

  defp smallest(n), do: find(n, 2)

  defp find(n, test) when test * test > n, do: n
  defp find(n, test) when rem(n, test) == 0, do: test
  defp find(n, test), do: find(n, test + 1)
end


ExUnit.start

defmodule UniquePairsTests do
  use ExUnit.Case, async: true

  test "no pairs when n is 1" do
    assert UniquePairs.of(1) == []
  end

  test "generates all pairs" do
    assert UniquePairs.of(3) == [[2, 1], [3, 1], [3, 2]]
  end
end

defmodule PrimeSumPairsTests do
  use ExUnit.Case, async: true

  test "it generates the expected pairs" do
    assert PrimeSumPairs.of(6) == [[2, 1], [3, 2], [4, 1], [4, 3], [5, 2], [6, 1], [6, 5]]
  end
end
                 
