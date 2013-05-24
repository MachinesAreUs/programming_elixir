
# 6.2 Function Calls and Pattern Matching

defmodule Times do
  
  # do..end sintax
  def double(n) do
    n * 2
  end
  # do: syntax
  def double_(n), do: n * 2
  
  # Extend the Timesmodule with a triplefunction, that multiplies its parameter by three.
  def triple(n), do: n * 3

  # Add a quadruplefunction
  def quadruple(n), do: double double(n)

end