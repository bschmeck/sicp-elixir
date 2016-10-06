defmodule AverageDamping do
  def damp(f), do: &(average(&1, f.(&1)))

  defp average(x, y), do: (x + y) / 2
end
