defmodule Interval do
  def make(lower, upper), do: [lower | upper]
  def lower(interval), do: hd interval
  def upper(interval), do: tl interval

  def add(x, y), do: make(lower(x) + lower(y), upper(x) + upper(y))
  
  def sub(x, y), do: make(lower(x) - upper(y), upper(x) - lower(y))
  
  def mul(x, y) do
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
  
  test "dividing by zero is an error" do
    numer = Interval.make 3, 7
    denom = Interval.make -3, 3
    assert_raise ArithmeticError, fn -> Interval.div(numer, denom) end
  end
end
