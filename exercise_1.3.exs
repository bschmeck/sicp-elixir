# Define a procedure that takes three numbers as arguments and returns the sum of the squares of the two larger numbers.

square = &(&1 * &1)
sum_of_squares = &(square.(&1) + square.(&2))
p = fn
  x, y, z when x > z and y > z -> sum_of_squares.(x, y)
  x, y, z when x > y and z > y -> sum_of_squares.(x, z)
  x, y, z when y > x and z > x -> sum_of_squares.(y, z)
end

IO.puts p.(1,2,3)
IO.puts p.(3,1,2)
IO.puts p.(2,3,1)
