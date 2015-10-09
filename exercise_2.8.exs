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
    mul(x, make(1 / upper(y), 1 / lower(y)))
  end
end
