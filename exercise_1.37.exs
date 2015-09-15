defmodule ContinuedFraction do
  def of(n, d, k), do: of(n, d, k, 1)
  def of(_, _, k, i) when i > k, do: 0
  def of(n, d, k, i) do
    numer = n.(i)
    denom = n.(i)
    numer / (denom + of(n, d, k, i + 1))
  end

  def of_iter(n, d, k) do
    iter(n, d, k, 0)
  end

  defp iter(_, _, 0, result), do: result
  defp iter(n, d, index, result) do
    numer = n.(index)
    denom = d.(index) + result
    iter(n, d, index - 1, numer / denom)
  end
end

n = fn _ -> 1 end
d = fn _ -> 1 end

IO.puts "Trying to find: #{ 1 / 1.61803398875 }"
IO.puts "k =  2: #{ContinuedFraction.of(n, d, 2)}"
IO.puts "k = 10: #{ContinuedFraction.of(n, d, 10)}"
IO.puts "k = 20: #{ContinuedFraction.of(n, d, 20)}"
IO.puts "k = 30: #{ContinuedFraction.of(n, d, 30)}"
IO.puts "k = 40: #{ContinuedFraction.of(n, d, 40)}"

ExUnit.start

defmodule ContinuedFractionTests do
  use ExUnit.Case, async: true

  test "recursive and iterative approaches are equivalent" do
    n = fn _ -> 1 end
    d = fn _ -> 1 end

    assert ContinuedFraction.of(n, d, 30) == ContinuedFraction.of_iter(n, d, 30)
  end
end
