# 7.2 Using Head and Tail to Process a List

defmodule MyList do

  # simple recursive processing
  def len([]), do: 0
  def len([_|tail]), do: 1 + len(tail)

  # usage of an accumulator
  def sum([], total), do: total
  def sum([ head | tail ], total), do: sum(tail, head+total)

end

IO.puts MyList.len([])                   == 0
IO.puts MyList.len([1, 2, 3])            == 3
IO.puts MyList.len([1, [[2, 3], [4,5]]]) == 2

# 7.5 Keeping Track of Values During Recursion

defmodule MyList do

  # usage of an accumulator
  def sum(list), do: _sum(list, 0)
  defp _sum([], total), do: total
  defp _sum([ head | tail ], total), do: _sum(tail, head+total)

end

IO.puts MyList.sum([1,2,3,4,5])      == 15
IO.puts MyList.sum([11,12,13,14,15]) == 65

# Generalization of the reduce function

defmodule MyList do
  def reduce([], value, _) do
   value
  end
  def reduce([head | tail], value, fun) do
    reduce(tail, fun.(head, value), fun)
  end
end

IO.puts MyList.reduce([1, 2, 3, 4], 0, &1 + &2) == 10
IO.puts MyList.reduce([1, 2, 3, 4], 1, &1 * &2) == 24

# Write a function mapsum that takes a list and a function. It applies the
# function to each element of the list, and then sums the result, so
# iex> MyList.mapsum [1, 2, 3], &1 * &1
# 14

defmodule MyList do
  
  # copied from above
  def sum(list), do: _sum(list, 0)
  defp _sum([], total), do: total
  defp _sum([ head | tail ], total), do: _sum(tail, head+total)

  # copied from above
  def map([], _func), do: []
  def map([ head | tail ], func), do: [ func.(head) | map(tail, func) ]

  # solution
  def mapsum(list, fun) do
    list |> map(fun) |> sum
  end
end

IO.puts MyList.mapsum( [1, 2, 3], &1 * &1)   == 14
IO.puts MyList.mapsum( [1, 2, 3], div(&1,2)) == 2

# Write max(list)that returns the element with the maximum value in the
# list. (This is slightly trickier than it sounds.)

defmodule MyList do

  def max( [h|t] ), do: _max [h|t], h

  defp _max( [], curr_max ), do: curr_max
  
  defp _max( [h|t], curr_max ) when curr_max >= h do
    _max t, curr_max
  end

  defp _max( [h|t], curr_max ) when curr_max < h do
    _max t, h
  end

end

IO.puts MyList.max( [23, 124, 42, 12, 245, 12] ) == 245
IO.puts MyList.max( [23, -12, 1, -24444, 12] )   == 23
IO.puts MyList.max( [-1323, 2, 0, -122121, 3] )  == 3

# An Elixir single quoted string is actually a list of individual chaacter codes.
# Write a function caesar(list, n)that adds  nto each element of the list, but
# wrapping if the addition results in a character greater than z.
# iex> MyList.caesar('ryvkve', 13)
# ?????? :)# 

defmodule MyList do

  def caesar( [], _n ), do: []
  def caesar( [h|t], n ), do: [_caesar(h, n) | caesar(t, n)]
  defp _caesar(x, n) when (x + n) > ?z, do: ?a - 1 + (x + n - ?z)
  defp _caesar(x, n), do: x + n

end

IO.puts MyList.caesar('abc', 1) == 'bcd'
IO.puts MyList.caesar('xyz', 3) == 'abc'
IO.puts MyList.caesar('azb', 5) == 'feg'
