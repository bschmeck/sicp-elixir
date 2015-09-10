defmodule Divisor do
  def smallest(n), do: find(n, 2)

  defp find(n, test) when test * test > n, do: n
  defp find(n, test) when rem(n, test) == 0, do: test
  defp find(n, test), do: find(n, test + 1)
end

IO.puts "Smallest divisor of   199: #{Divisor.smallest(199)}"
IO.puts "Smallest divisor of  1999: #{Divisor.smallest(1999)}"
IO.puts "Smallest divisor of 19999: #{Divisor.smallest(19999)}"
