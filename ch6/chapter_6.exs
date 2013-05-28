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

# 6.6 Modules and 6.8 Module Names: Elixiir, Erlang and Atoms

# Convert a float to a string with 2 decimal digits. (Erlang)
IO.puts :io_lib.format("~.2f", [10.12345]) == ['10.12']

# Get the value of an operating system environment variable. (Elixir)
  import System
put_env "var_x", "x"
IO.puts get_env("var_x") == "x"

# Return the extension component of a file name (so return .exs if given "dave/test.exs")

IO.puts ( "filename.exs" |> String.split(".") |> List.last ) == "exs"

# Return the current working directory of the process. (Elixir)

import File
 {ok, _} = File.cwd()
 IO.puts ok != nil

# Convert a string containing JSON into Elixir data structures. 
# (Just find, don’t install)

IO.puts "https://github.com/guedes/exjson" != nil

# Execute an command in your operating system’s shell

IO.puts :os.getenv() != nil # Bug -> :os.cmd("dir") raises an error on Win64