defmodule CountChange do
  def us_coins, do: [50, 25, 10, 5, 1]
  def uk_coins, do: [100, 50, 20, 10, 5, 2, 1, 0.5]

  def count(0, _), do: 1
  def count(amount, _) when amount < 0, do: 0
  def count(_, []), do: 0
  def count(amount, [first_coin | rest_coins]) do
    count(amount, rest_coins) + count(amount - first_coin, [first_coin | rest_coins])
  end
end
