defmodule OrderedTriples do
  def sum_to(s, n) when n < 3, do: []
  def sum_to(s, n) do
    unique_triples(n) |>
      Enum.filter(fn([i, j, k]) -> i + j + k == s end)
  end

  defp unique_tripes(n) when n < 3, do: []
  defp unique_triples(n) do
    Enum.flat_map(3..n, fn(i) ->
      UniquePairs.of(i) |>
        Enum.map(fn(arr) -> [i | arr] end)
    end)
  end
end

ExUnit.start

defmodule OrderedTriplesTests do
  use ExUnit.Case, async: true

  test "no triples when n = 2" do
    assert OrderedTriples.sum_to(5, 2) == []
  end

  test "no triples when n = 1" do
    assert OrderedTriples.sum_to(5, 1) == []
  end

  test "it finds triples" do
    target = 10
    assert length(OrderedTriples.sum_to(10, 6)) > 0
  end

  test "it returns triples that sum to the given number" do
    target = 10
    triples = OrderedTriples.sum_to(target, 6)
    assert Enum.map(triples, fn(triple) -> Enum.reduce(triple, &(&1 + &2)) end) |> Enum.all?(&(&1 == target))
  end
end
