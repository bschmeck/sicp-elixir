defmodule Pascal do
  def element(_, 0), do: 1
  def element(row, pos) when row == pos, do: 1

  def element(row, pos), do: element(row-1, pos-1) + element(row-1, pos)
end

# View triangle as:
# 1
# 1 1
# 1 2 1
# 1 3 3 1
# 1 4 6 4 1