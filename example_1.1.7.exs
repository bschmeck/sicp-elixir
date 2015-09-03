defmodule SquareRoot do
  def sqrt(x) do
    sqrt_iter(1.0, x)
  end

  defp average(a, b) do
    (a + b) / 2
  end

  defp improve(guess, x) do
    average(guess, x / guess)
  end

  defp good_enough?(guess, x) do
    accuracy = abs(guess * guess - x)
    threshold = 0.001
    accuracy < threshold
  end

  defp sqrt_iter(guess, x) do
    if good_enough? guess, x do
      guess
    else
      sqrt_iter(improve(guess, x), x)
    end
  end
end
