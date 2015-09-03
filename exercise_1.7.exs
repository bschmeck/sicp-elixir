defmodule Exercise_1_7 do
  def sqrt(x) do
    sqrt_iter(1.0, x)
  end

  defp average(a, b) do
    (a + b) / 2
  end

  defp improve(guess, x) do
    average(guess, x / guess)
  end

  def good_enough?(guess, x) do
    improved = improve(guess, x)
    improvement = abs(1 - improved / guess)
    threshold = 0.0000001
    improvement < threshold
  end

  defp sqrt_iter(guess, x) do
    if good_enough? guess, x do
      guess
    else
      sqrt_iter(improve(guess, x), x)
    end
  end
end
