defmodule Pascal do
  def element(_, 0), do: 1
  def element(row, pos) when row == pos, do: 1

  def element(row, pos), do: element(row-1, pos-1) + element(row-1, pos)
end

ExUnit.start

defmodule PascalTests do
  use ExUnit.Case, async: true

  test "it computes elements in Pascal's triangle" do
    assert Pascal.element(0, 0) == 1
    assert Pascal.element(1, 1) == 1
    assert Pascal.element(3, 2) == 3
    assert Pascal.element(4, 3) == 4
    assert Pascal.element(7, 2) == 21
  end
end
# View triangle as:
# 1
# 1 1
# 1 2  1
# 1 3  3  1
# 1 4  6  4  1
# 1 5 10 10  5  1
# 1 6 15 20 15  6 1
# 1 7 21 35 35 21 7 1
