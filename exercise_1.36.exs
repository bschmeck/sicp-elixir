defmodule FixedPoint do
  @tolerance 0.00001

  def of(f, guess) do
    IO.puts "Guess: #{guess}"
    next = f.(guess)
    if close_enough? guess, next do
      next
    else
      of(f, next)
    end
  end

  def damped(f, guess) do
    IO.puts "Guess: #{guess}"
    next = f.(guess)
    if close_enough? guess, next do
      next
    else
      damped(f, (next + guess) / 2)
    end
  end

  defp close_enough?(val1, val2), do: abs(val1 - val2) < @tolerance
end

IO.puts "Answer: #{FixedPoint.of(&(:math.log(1000) / :math.log(&1)), 2)}"
IO.puts "==="
IO.puts "Answer: #{FixedPoint.damped(&(:math.log(1000) / :math.log(&1)), 2)}"

# Damped Approach: 10 guesses
# Non-damped: 34 guesses
