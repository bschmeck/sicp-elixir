defmodule Interval do
  def make(lower, upper), do: [lower | upper]
  def lower(interval), do: hd interval
  def upper(interval), do: tl interval

  def add(x, y), do: make(lower(x) + lower(y), upper(x) + upper(y))
  
  def sub(x, y), do: make(lower(x) - upper(y), upper(x) - lower(y))

  # L1 -, U1 -, L2 -, U2 - -> [U1 * U2, L1 * L2]
  # L1 -, U1 -, L2 -, U2 + -> [L1 * U2, U1 * L2]
  # L1 -, U1 -, L2 +, U2 + -> [L1 * U2, U1 * L2]
  
  # L1 -, U1 +, L2 -, U2 - -> [U1 * L2, L1 * U2]
  # L1 -, U1 +, L2 -, U2 + -> [min(L1 * U2, U1 * L2), U1 * U2]
  # L1 -, U1 +, L2 +, U2 + -> [L1 * U2, U1 * U2]
  
  # L1 +, U1 +, L2 -, U2 - -> [U1 * U2, L1 * U2]
  # L1 +, U1 +, L2 -, U2 + -> [U1 * L2, U1 * U2]
  # L1 +, U1 +, L2 +, U2 + -> [L1 * L2, U1 * U2]
  def mul(x, y) do
    lower = case { lower(x), upper(x), lower(y), upper(y) } do
              {a, b, c, d} when a < 0 and b < 0 and c < 0 and d < 0 -> b * d
              {a, b, c, d} when a >= 0 and b >= 0 and c >= 0 and d >= 0 -> a * c
              {a, b, c, d} when a < 0 and b >= 0 and c < 0 and d >= 0 -> Enum.min([a * d, b * c])
              {a, _, _, d} when a < 0 and d >= 0 -> a * d
              {_, b, c, _} when b >= 0 and c < 0 -> b * c
            end
    upper = case { lower(x), upper(x), lower(y), upper(y) } do
              {_, b, _, d} when b >= 0 and d >= 0 -> b * d
              {a, _, c, _} when a < 0 and c < 0 -> a * c
              {a, _, _, d} when a >= 0 and d < 0 -> a * d
              {_, b, c, _} when b < 0 and c >= 0 -> b * c
            end
    make(lower, upper)
  end
  
  def alyssa_mul(x, y) do
    p1 = lower(x) * lower(y)
    p2 = lower(x) * upper(y)
    p3 = upper(x) * lower(y)
    p4 = upper(x) * upper(y)

    make Enum.min([p1, p2, p3, p4]), Enum.max([p1, p2, p3, p4])
  end
  
  def div(x, y) do
    if span_zero?(y) do
      raise ArithmeticError, message: "cannot divide by interval spanning zero"
    end
    mul(x, make(1 / upper(y), 1 / lower(y)))
  end

  def span_zero?(interval), do: lower(interval) <= 0 && upper(interval) >= 0
end

ExUnit.start

defmodule IntervalTests do
  use ExUnit.Case, async: true

  test "it multiplies [-, -] * [-, -]" do
    neg_neg = Interval.make -10, -5
    assert Interval.mul(neg_neg, neg_neg) == Interval.alyssa_mul(neg_neg, neg_neg)
  end

  test "it multiplies [-, -] * [-, +]" do
    neg_neg = Interval.make -10, -5
    neg_pos = Interval.make -5, 5
    assert Interval.mul(neg_neg, neg_pos) == Interval.alyssa_mul(neg_neg, neg_pos)
  end

  test "it multiplies [-, -] * [+, +]" do
    neg_neg = Interval.make -10, -5
    pos_pos = Interval.make 5, 10
    assert Interval.mul(neg_neg, pos_pos) == Interval.alyssa_mul(neg_neg, pos_pos)
  end

  test "it multiplies [-, +] * [-, -]" do
    neg_neg = Interval.make -10, -5
    neg_pos = Interval.make -5, 5
    assert Interval.mul(neg_pos, neg_neg) == Interval.alyssa_mul(neg_pos, neg_neg)
  end

  test "it multiplies [-, +] * [-, +]" do
    neg_pos = Interval.make -5, 5
    assert Interval.mul(neg_pos, neg_pos) == Interval.alyssa_mul(neg_pos, neg_pos)
  end

  test "it multiplies [-, +] * [+, +]" do
    neg_pos = Interval.make -5, 5
    pos_pos = Interval.make 5, 10
    assert Interval.mul(neg_pos, pos_pos) == Interval.alyssa_mul(neg_pos, pos_pos)
  end

  test "it multiplies [+, +] * [-, -]" do
    neg_neg = Interval.make -10, -5
    pos_pos = Interval.make 5, 10
    assert Interval.mul(pos_pos, neg_neg) == Interval.alyssa_mul(pos_pos, neg_neg)
  end

  test "it multiplies [+, +] * [-, +]" do
    neg_pos = Interval.make -5, 5
    pos_pos = Interval.make 5, 10
    assert Interval.mul(pos_pos, neg_pos) == Interval.alyssa_mul(pos_pos, neg_pos)
  end

  test "it multiplies [+, +] * [+, +]" do
    pos_pos = Interval.make 5, 10
    assert Interval.mul(pos_pos, pos_pos) == Interval.alyssa_mul(pos_pos, pos_pos)
  end
end
