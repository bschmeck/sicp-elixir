defmodule SquareRoot do
  def sqrt(x) do
    average = fn(a, b) ->
      (a + b) / 2
    end
    improve = fn(guess) ->
      average.(guess, x / guess)
    end
    good_enough? = fn(guess) ->
      accuracy = abs(guess * guess - x)
      threshold = 0.001
      accuracy < threshold
    end
    sqrt_iter = fn([]) -> 0 end
    sqrt_iter = fn(guess)
      if good_enough?.(guess) do
        guess
      else
        # This doesn't work, because Elixir does not currently support
        # recursive anonymous functions
        sqrt_iter.(improve.(guess))
      end
    end
    sqrt_iter.(1.0)
  end
end
