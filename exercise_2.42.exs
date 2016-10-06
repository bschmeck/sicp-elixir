defmodule Queens do
  def board(size) do
    columns(size, size)
  end

  defp columns(0, _board_size), do: [ [] ]
  defp columns(k, board_size) do
    columns(k - 1, board_size)
    |> Enum.flat_map(&(append_to_queens &1, k, board_size))
    |> Enum.filter(&(safe? &1))
  end

  defp append_to_queens(rest, k, board_size) do
    Enum.map(1..board_size, &(adjoin_position(&1, k, rest)))
  end

  defp adjoin_position(row, col, others), do: [make_cell(row, col) | others]

  defp safe?([new_position | others]) do
    # Safe means:
    # 1. No queens in same row
    # 2. No queens in same column
    # 3. No queens on same diagonal

    !Enum.any? others,
      fn(pos) -> same_row?(pos, new_position) || same_column?(pos, new_position) || same_diagonal?(pos, new_position)
    end
  end

  defp same_row?(p1, p2), do: row_of(p1) == row_of(p2)
  defp same_column?(p1, p2), do: column_of(p1) == column_of(p2)
  defp same_diagonal?(p1, p2), do: abs(row_of(p1) - row_of(p2)) == abs(column_of(p1) - column_of(p2))

  defp make_cell(row, column), do: [row | column]

  defp column_of(position), do: tl position
  defp row_of(position), do: hd position
end
