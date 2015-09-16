defmodule ContinuedFraction do
  def of(n, d, k) do
    iter(n, d, k, 0)
  end

  defp iter(_, _, 0, result), do: result
  defp iter(n, d, index, result) do
    numer = n.(index)
    denom = d.(index) + result
    # IO.puts "#{index} n: #{n.(index)} d: #{d.(index)}"
    iter(n, d, index - 1, numer / denom)
  end
end

defmodule Tangent do
  def of(x, k) do
    n = fn
      1 -> x
      _ -> -1 * x * x
    end
    d = fn i -> 2 * i - 1 end
    ContinuedFraction.of(n, d, k)
  end
end

IO.puts "Looking for tan(60) = 0.32004038938"
IO.puts "k =   4:    tan(60) = #{Tangent.of(60, 4)}"
IO.puts "k =  10:    tan(60) = #{Tangent.of(60, 10)}"
IO.puts "k =  20:    tan(60) = #{Tangent.of(60, 20)}"
IO.puts "k =  30:    tan(60) = #{Tangent.of(60, 30)}"
IO.puts "k =  40:    tan(60) = #{Tangent.of(60, 40)}"
IO.puts "k = 100:    tan(60) = #{Tangent.of(60, 100)}"
IO.puts "k = 200:    tan(60) = #{Tangent.of(60, 200)}"
