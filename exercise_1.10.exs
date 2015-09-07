defmodule Ackermann do
  def of(_, 0), do: 0
  def of(0, y), do: 2 * y
  def of(_, 1), do: 2
  def of(x, y) do
    of(x-1, of(x, y-1))
  end
end

IO.puts "Ackermann.of(1, 10): #{Ackermann.of(1, 10)}"
IO.puts "Ackermann.of(2, 4): #{Ackermann.of(2, 4)}"
IO.puts "Ackermann.of(3, 3): #{Ackermann.of(3, 3)}"

ExUnit.start

defmodule AckermannTests do
  use ExUnit.Case, async: true

  test "Ackermann.of(0, n) computes 2 * n" do
    assert Ackermann.of(0, 4) == 2 * 4
    assert Ackermann.of(0, 10) == 2 * 10
  end

  test "Ackermann.of(1, n) computes 2 ^ n" do
    assert Ackermann.of(1, 4) == :math.pow(2, 4)
    assert Ackermann.of(1, 10) == :math.pow(2, 10)
  end

  test "Ackermann.of(2, n) computes 2 ^ 2 ^ 2 ... (n times)" do
    assert Ackermann.of(2, 2) == :math.pow(2, 2)
    assert Ackermann.of(2, 4) == :math.pow(2, 16)
    # :math.pow can't handle large exponents, so although we'd like to write this test,
    # we can't:
    # assert Ackermann.of(2, 5) == :math.pow(2, 65536)
  end
end

# h = fn(n) -> Ackermann.of(2, n) computes 2 ^ 2 ^ n ???
# 2, 5
# 1, (2, 4) -> 2 ^ (2, 4)
# 2 ^ (1, (2, 3)) -> 2 ^ (2 ^ (2, 3))
# 2 ^ 2 ^ 2 ^ (2, 2)
# 2 ^ 2 ^ 2 ^ 2 ^ (2, 1) ->
# 2 ^ 2 ^ 2 ^ 2 ^ 2 ->
# 2 ^ 2 ^ 2 ^ 4
# 2 ^ 2 ^ 16
# 2 ^ 65536

# 1 -> 2 = 2 ^ 1
# 2 -> 4 = 2 ^ 2
# 3 -> 16 = 2 ^ 4
# 4 -> 65536 = 2 ^ 16
# 5 -> BIG = 2 ^ 65536
