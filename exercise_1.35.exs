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

ExUnit.start

defmodule FixedPointTests do
  use ExUnit.Case, async: true

  test "computes the Golden Ratio" do
    computed_phi = FixedPoint.of(&(1 + 1 / &1), 1.0)
    actual_phi = 1.61803398875
    assert_in_delta computed_phi, actual_phi, 0.00001
  end
end
