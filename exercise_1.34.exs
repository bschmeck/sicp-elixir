f = fn g -> g.(2) end

square = &(&1 * &1)

f.(square)
# 4
f.(&(&1 * (&1 + 1)))
# 6
f.(f)
# ** (BadFunctionError) expected a function, got: 2
# Via substitution, we're executing 2.(2)
