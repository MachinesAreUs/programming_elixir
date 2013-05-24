# 6.3 Guard Clauses

defmodule Guard do
  def what_is(x) when is_number(x) do
    "#{x} is a number"
  end
  def what_is(x) when is_list(x) do
    "#{inspect(x)} is a list"
  end
  def what_is(x) when is_atom(x) do
    "#{x} is an atom"
  end
end

IO.puts Guard.what_is(99)      == "99 is a number"
IO.puts Guard.what_is(:cat)    == "cat is an atom"
IO.puts Guard.what_is([1,2,3]) == "[1,2,3] is a list"