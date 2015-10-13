defmodule Interval do
  def make(lower, upper), do: [lower | upper]
  def lower(interval), do: hd interval
  def upper(interval), do: tl interval

  def make_center_width(c, w), do: make(c - w, c + w)
  def center(interval), do: (lower(interval) + upper(interval)) / 2
  def width(interval), do: (upper(interval) - lower(interval)) / 2

  def make_center_percentage(c, p), do: make(c * (1 - p / 2), c * (1 + p / 2))
  def percentage(interval), do: 2 * width(interval) / center(interval)
  
  def add(x, y), do: make(lower(x) + lower(y), upper(x) + upper(y))
  
  def sub(x, y), do: make(lower(x) - upper(y), upper(x) - lower(y))

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

  test "it creates an interval from a center and percentage" do
    i = Interval.make_center_percentage(10, 0.15)
    assert Interval.width(i) == 0.75
    assert Interval.center(i) == 10
  end

  test "it retrieves the percentage from an interval" do
    p = 0.075
    i = Interval.make_center_percentage(5, p)
    assert Interval.percentage(i) == p
  end
end
