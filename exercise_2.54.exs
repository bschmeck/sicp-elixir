defmodule Equality do
  def equal?([], []), do: true
  def equal?([head1 | tail1], [head2 | tail2]), do: equal?(head1, head2) && equal?(tail1, tail2)
  def equal?(a, b) when is_atom(a) and is_atom(b), do: a == b
  def equal?(_, _), do: false
end

ExUnit.start

defmodule EqualityTests do
  use ExUnit.Case, async: true

  test "empty lists are equal" do
    assert Equality.equal?([], [])
  end

  test "single element lists are equal if the elements are equal" do
    assert Equality.equal?([:a], [:a])
    refute Equality.equal?([:a], [:b])
  end

  test "lists of unequal length are not equal" do
    refute Equality.equal?(~w(foo bar baz bat)a, ~w(foo bar baz)a)
    refute Equality.equal?(~w(foo bar baz bat)a, ~w(foo bar baz bat qux)a)
  end

  test "lists of equal length with matching elements are equal" do
    assert Equality.equal?(~w(foo bar baz bat qux)a, ~w(foo bar baz bat qux)a)
  end
end
