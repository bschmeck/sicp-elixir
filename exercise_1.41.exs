defmodule Doubler do
  def double(f), do: fn x -> f.(f.(x)) end
end

ExUnit.start

defmodule DoublerTests do
  use ExUnit.Case, async: true

  test "it double increments" do
    inc = &(&1 + 1)
    dbl = Doubler.double(inc)

    assert dbl.(2) == 4
  end

  test "it can double itself" do
    inc = &(&1 + 1)
    dblr = &Doubler.double/1
    assert dblr.(dblr.(dblr)).(inc).(5) == 21
  end
end
