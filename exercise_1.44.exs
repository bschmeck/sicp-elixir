defmodule Smooth do
  def smooth(f), do: fn x -> (f.(x - dx) + f.(x) + f.(x + dx)) / 3 end
  def n_fold_smooth(f, n), do: Repeat.n_times(smooth(f), n)
  defp dx, do: 0.001
end
