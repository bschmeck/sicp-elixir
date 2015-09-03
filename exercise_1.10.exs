defmodule Ackermann do
  def of(_, 0), do: 0
  def of(0, y), do: 2 * y
  def of(_, 1), do: 2
  def of(x, y) do
    of(x-1, of(x, y-1))
  end
end

# f = fn(n) -> Ackermann.of(0, n) computes 2 * n
# g = fn(n) -> Ackermann.of(1, n) computes 2 ^ n
# h = fn(n) -> Ackermann.of(2, n) computes 2 ^ 2 ^ n ???
2, 5
1, (2, 4) -> 2 ^ (2, 4)
2 ^ (1, (2, 3)) -> 2 ^ (2 ^ (2, 3))
2 ^ 2 ^ 2 ^ (2, 2)
2 ^ 2 ^ 2 ^ 2 ^ (2, 1) ->
2 ^ 2 ^ 2 ^ 2 ^ 2 ->
2 ^ 2 ^ 2 ^ 4
2 ^ 2 ^ 16
2 ^ 65536

1 -> 2 = 2 ^ 1
2 -> 4 = 2 ^ 2
3 -> 16 = 2 ^ 4
4 -> 65536 = 2 ^ 16
5 -> BIG = 2 ^ 65536
