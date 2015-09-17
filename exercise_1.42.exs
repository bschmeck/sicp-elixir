defmodule Composition do
  def of(f, g), do: fn x -> f.(g.(x)) end
end

ExUnit.start

defmodule CompositionTests do
  use ExUnit.Case, async: true

  test "it composes two procedures" do
    square = &(&1 * &1)
    inc = &(&1 + 1)

    assert Composition.of(square, inc).(6) == 49
  end
end
