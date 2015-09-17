defmodule Composition do
  def of(f, g), do: fn x -> f.(g.(x)) end
end

defmodule Repeat do
  def n_times(f, 1), do: f
  def n_times(f, n) when rem(n, 2) == 0 do
    g = n_times(f, div(n, 2))
    Composition.of(g, g)
  end
  def n_times(f, n), do: fn x -> f.(n_times(f, n - 1).(x)) end
end

ExUnit.start

defmodule RepeatTests do
  use ExUnit.Case, async: true

  test "it repeats function application" do
    square = &(&1 * &1)
    assert Repeat.n_times(square, 2).(5) == 625
  end

  test "it repeats more than twice" do
    inc = &(&1 + 1)
    assert Repeat.n_times(inc, 4).(5) == 9
    assert Repeat.n_times(inc, 10).(5) == 15
    assert Repeat.n_times(inc, 27).(5) == 32
  end
end
