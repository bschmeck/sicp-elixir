defmodule CubeRoot do
  def of(x) do
    iter(1.0, x)
  end

  defp improve(guess, x) do
    numerator = x / (guess * guess) + 2 * guess
    numerator / 3
  end

  def good_enough?(guess, x) do
    improved = improve(guess, x)
    improvement = abs(1 - improved / guess)
    threshold = 0.0000001
    improvement < threshold
  end

  defp iter(guess, x) do
    if good_enough? guess, x do
      guess
    else
      iter(improve(guess, x), x)
    end
  end
end

ExUnit.start

defmodule CubeRootTests do
  use ExUnit.Case, async: true

  test "it calcs cube roots within a threshold" do
    assert abs(CubeRoot.of(8) - 2) < 0.000001
    assert abs(CubeRoot.of(1000) - 10) < 0.000001
  end
end
