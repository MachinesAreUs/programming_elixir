# 6.2 Function Calls and Pattern Matching

# Implement and run a function sum(n)that uses recursion to calculate the
# sum of the integers from 1 to n. You’ll need to write this function inside
# a module in a separate file.

defmodule SumUp do
  def to(0), do: 0
  def to(n), do: n + to(n-1)
end

IO.puts SumUp.to(0) == 0
IO.puts SumUp.to(1) == 1
IO.puts SumUp.to(2) == 3
IO.puts SumUp.to(3) == 6
IO.puts SumUp.to(4) == 10

# Write a function gcd(x,y)that finds the greatest common divisor between
# two nonnegative integers. 
# Algebraically, gcd(x,y)is x if y is zero, gcd(y,rem(x,y)) otherwise

defmodule GDC do
  def for(x, 0), do: x
  def for(x, y), do: for(y, rem(x,y))
end

IO.puts GDC.for(2, 0)   == 2
IO.puts GDC.for(9, 6)   == 3
IO.puts GDC.for(21, 30) == 3
IO.puts GDC.for(21, 49) == 7
IO.puts GDC.for(24, 6)  == 6