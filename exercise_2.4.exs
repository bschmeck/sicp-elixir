cons = fn (x, y) -> 
  fn (m) -> m.(x, y) end
end

car = fn (z) ->
  z.(fn (p, q) -> p end)
end

cdr = fn (z) ->
  z.(fn (p, q) -> q end)
end
