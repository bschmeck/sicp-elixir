defmodule LastPair do
  def of([head | []]), do: [head]
  def of([head | tail]), do: of(tail)
end

ExUnit.start

defmodule LastPairTest do
  use ExUnit.Case, async: true

  test "it finds the last element in the list" do
    assert LastPair.of([23, 72, 149, 34]) == [34]
  end
end
