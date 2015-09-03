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

ExUnit.start

defmodule NewIfTests do
  use ExUnit.Case, async: true

  test "it evaluates the then clause if predicate is true" do
    new_if 1 == 1, assert(true == true), assert(false == false)
  end
end
