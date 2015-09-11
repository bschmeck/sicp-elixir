defmodule Root do
  def via_half_interval(f, a, b) do
    a_value = f.(a)
    b_value = f.(b)
    cond do
      a_value < 0 && b_value > 0 -> search(f, a, b)
      b_value < 0 && a_value > 0 -> search(f, b, a)
    end
  end

  def search(f, neg, pos) do
    midpoint = (neg + pos) / 2
    if close_enough?(neg, pos) do
      return midpoint
    end
    
    test_value = f.(midpoint)
    case test_value do
      0 -> midpoint
      x when x > 0 -> search(f, neg, midpoint)
      _ -> search(f, midpoint, pos)
    end
  end

  defp close_enough?(a, b), do: abs(a - b) < 0.001
end
