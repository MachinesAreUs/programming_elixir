# 6.2 Function Calls and Pattern Matching

defmodule Factorial do
  def of(0), do: 1
  # Without guard: 
  #   def of(n), do: n * of(n-1)
  # With guard: 
  def of(n) when n > 0 do
    n * of(n-1)
  end
end