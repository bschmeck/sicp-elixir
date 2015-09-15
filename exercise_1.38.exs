defmodule ContinuedFraction do
  def of(n, d, k) do
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
d = fn
  i when rem(i, 3) == 2 -> 2 * (div(i, 3) + 1)
  _ -> 1
end

IO.puts "Looking for e = 2.7182818284590452353602875"
IO.puts "k =  2:     e = #{2 + ContinuedFraction.of(n, d, 2)}"
IO.puts "k = 10:     e = #{2 + ContinuedFraction.of(n, d, 10)}"
IO.puts "k = 20:     e = #{2 + ContinuedFraction.of(n, d, 20)}"
IO.puts "k = 30:     e = #{2 + ContinuedFraction.of(n, d, 30)}"
IO.puts "k = 40:     e = #{2 + ContinuedFraction.of(n, d, 40)}"
