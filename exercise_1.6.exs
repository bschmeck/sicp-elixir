# Define an if operator in terms of cond

defmodule NewIf do
  defmacro new_if(predicate, then_clause, else_clause) do
    quote do
      cond do
        unqote(predicate) -> unquote(then_clause)
        true -> unquote(else_clause)
      end
    end
  end
end