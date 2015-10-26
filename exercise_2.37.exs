defmodule Accumulate do
  def accum(_op, init, []), do: init
  def accum(op, init, [head | tail]), do: op.(head, accum(op, init, tail))

  def accum_n(_op, _init, [ [] | _tail]), do: []
  def accum_n(op, init, list) do
    heads = Enum.map(list, &(hd &1))
    tails = Enum.map(list, &(tl &1))
    [ accum(op, init, heads) | accum_n(op, init, tails) ]
  end
end

defmodule Matrix do
  def times_vector(m, v), do: Enum.map(m, fn(row) -> Vector.dot_product(row, v) end)

  def transpose(m), do: Accumulate.accum_n(&([&1 | &2]), [], m)

  def times_matrix(m, n) do
    cols = transpose(n)
    Enum.map(m, &(times_vector(cols, &1)))
  end
end

defmodule Vector do
  def dot_product(v, w) do
    # Zip gives you a list of tuples
    zipped = Enum.zip(v, w)
    products = Enum.map(zipped, &(elem(&1, 0) * elem(&1, 1)))
    Accumulate.accum(&(&1 + &2), 0, products)
  end
end

ExUnit.start

defmodule AccumulateTests do
  use ExUnit.Case, async: true

  test "Vector computes dot products" do
    v = [2, 2, 2]
    w = [4, 4, 4]
    assert Vector.dot_product(v, w) == 24
  end

  test "Matrix times vector computes a vector" do
    m = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
    v = [2, 2, 2]
    assert Matrix.times_vector(m, v) == [12, 30, 48]
  end

  test "Matrix transpose flips the array" do
    m = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
    t = [[1, 4, 7], [2, 5, 8], [3, 6, 9]]

    assert Matrix.transpose(m) == t
  end

  test "Matrix multiplication works with the identity matrix" do
    m = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
    n = [[1, 0, 0], [0, 1, 0], [0, 0, 1]]
    assert Matrix.times_matrix(m, n) == m
  end

  test "Matrix multiplication can square a matrix" do
    m = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
    n = [[30, 36, 42], [66, 81, 96], [102, 126, 150]]
    assert Matrix.times_matrix(m, m) == n
  end
end

