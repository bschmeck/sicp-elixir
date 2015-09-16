defmodule FixedPoint do
  @tolerance 0.00001

  def of(f, guess) do
    next = f.(guess)
    if close_enough? guess, next do
      next
    else
      of(f, next)
    end
  end

  defp close_enough?(val1, val2), do: abs(val1 - val2) < @tolerance
end

defmodule NewtonsMethod do
  def root_of(g, guess) do
    FixedPoint.of transform(g), guess
  end

  def transform(g) do
    fn x ->
      x - (g.(x) / deriv(g).(x))
    end
  end

  def deriv(g) do
    fn x ->
      (g.(x + dx) - g.(x)) / dx
    end
  end

  defp dx, do: 0.00001
end

sqrt = fn x -> NewtonsMethod.root_of(&(:math.pow(&1, 2) - x), 1) end

IO.puts "Square Root of 4: #{sqrt.(4)}"
IO.puts "Square Root of 100: #{sqrt.(100)}"
IO.puts "Square Root of 125: #{sqrt.(125)}"
