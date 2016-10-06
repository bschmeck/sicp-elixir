defmodule Derivative do
  def of(exp, var) do
    cond do
      is_number(exp) -> 0
      is_var(exp) and exp == var -> 1
      is_var(exp) -> 0
      is_sum(exp) ->
        make_sum(
          of(addend(exp), var),
          of(augend(exp), var)
        )
      is_product(exp) ->
        make_sum(
          make_product(multiplier(exp), of(multiplicand(exp), var)),
          make_product(of(multiplier(exp), var), multiplicand(exp))
        )
      is_exponentiation(exp) ->
        make_product(
          make_product(exponent(exp),
                       make_exponentiation(base(exp), exponent(exp) - 1)),
          of(base(exp), var)
        )             
      true -> { :error }
    end
  end

  def is_var(x), do: is_atom x

  def make_sum(a1, 0), do: a1
  def make_sum(0, a2), do: a2
  def make_sum(a1, a2) when is_number(a1) and is_number(a2), do: a1 + a2
  def make_sum(a1, a2), do: [:+, a1, a2]

  def is_sum([:+ | _]), do: true
  def is_sum(_), do: false

  def addend([:+ | [ head | _tail]), do: head
  def augend([:+ | [ _head | tail]), do: tail

  def make_product(_, 0), do: 0
  def make_product(0, _), do: 0
  def make_product(m1, 1), do: m1
  def make_product(1, m2), do: m2
  def make_product(m1, m2) when is_number(m1) and is_number(m2), do: m1 * m2
  def make_product(m1, m2), do: [:*, m1, m2]

  def is_product([:* | _]), do: true
  def is_product(_), do: false

  def multiplier(p), do: hd tl p
  def multiplicand(p), do: hd tl tl p

  def make_exponentiation(_, 0), do: 1
  def make_exponentiation(u, 1), do: u
  def make_exponentiation(u, n), do: [:^, u, n]

  def is_exponentiation([:^ | _]), do: true
  def is_exponentiation(_), do: false

  def base(exp), do: hd tl exp
  def exponent(exp), do: hd tl tl exp
end

ExUnit.start

defmodule DerivativeTests do
  use ExUnit.Case, async: true
  
  test "it can take derviatives of sums" do
    assert(Derivative.of([:+, :x, 3], :x) == 1)
  end

  test "it can take derivatives of products" do
    assert(Derivative.of([:*, :x, :y], :x) == :y)
  end

  test "it can do complicated stuff" do
    expression = [:*, [:*, :x, :y], [:+, :x, 3]]
    derivative = [:+, [:*, :x, :y], [:*, :y, [:+, :x, 3]]]
    assert(Derivative.of(expression, :x) == derivative)
  end

  test "it can take derivatives of exponents" do
    expression = [:^, :x, 3]
    derivative = [:*, 3, [:^, :x, 2]]
    assert(Derivative.of(expression, :x) == derivative)
  end
end
