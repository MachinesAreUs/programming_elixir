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

# 7.7 List Comprehensions

# Samples

IO.puts (lc x inlist :lists.seq(1,5), do: x * x) == [1, 4, 9, 16, 25]
# Damdn elixir: (lc x inlist 1..5, do: x * x) == [1, 4, 9, 16, 25]
IO.puts length(lc x inlist :lists.seq(1,100), 
                  y inlist :lists.seq(1,100), 
                  x >= y, 
                  x + y == 100, 
                  do: {x, y}) == 50
IO.puts (lc x inlist [1, 2], 
            y inlist ['x', 'y'], 
            do: {x, y}
        ) == [{1,'x'},{1,'y'},{2,'x'},{2,'y'}]

# Chapter Excercises (after 7.8)

# Implement the following Enum functions using no library functions or
# list comprehensions: all?, each, filter, split, and take

defmodule Enum2 do

  def all?([], _fun), do: true
  def all?([h|t], fun), do: fun.(h) and all?(t, fun)

  # def filter([], _fun), do: []
  # def filter([h|t], fun) when fun.(h), do: [h | filter(t, fun)]
  # def filter([h|t], fun), do: filter(t, fun)
end

IO.puts Enum2.all? :lists.seq(1, 100), &1 > 0
IO.puts Enum2.all? :lists.seq(0, 100, 2), fn x -> rem(x,2) == 0 end
IO.puts Enum2.all? :lists.seq(3, 333, 3), fn x -> rem(x,3) == 0 end 

# Write a function MyList.span(from, to) that returns a list of the numbers
# from from "up" to "to".

defmodule Enum3 do
  def span(from, to) when to <= from, do: [from]
  def span(from, to) when from + 1 == to, do: [from | [to]]
  def span(from, to), do: [ from | span(from+1, to)]
end

IO.puts Enum3.span(5, 6) == [5, 6]
IO.puts Enum3.span(11, 20) == [11,12,13,14,15,16,17,18,19,20]

# Use your span function and list comprehensions to return a list of the
# prime numbers from 2 to n.

defmodule Primes do
  def primes_up_to(n) do
    lc x inlist Enum3.span(2, n), 
      # x == 2 is stupid! :(
      x == 2 or (Enum.all? (lc y inlist Enum3.span(2, div(x, 2)), do: rem(x, y) != 0) ), 
      do: x
  end
end

IO.puts Primes.primes_up_to(10) == [2, 3, 5, 7]
IO.puts Primes.primes_up_to(40) == [2, 3, 5, 7, 11, 13, 23, 29, 37]


# Pragmatic Bookshelf has offices in Texas (TX) and North Carolina (NC),
# so we have to charge sales tax on orders shipped to these states. The
# rates can be expressed as a keyword list
#
# tax_rates = [ NC: 0.075, TX: 0.08 ]
# 
# Here’s a list of orders:
# 
# orders = [
#   [ id: 123, ship_to: :NC, net_amount: 100.00 ],
#   [ id: 124, ship_to: :OK, net_amount:  35.50 ], 
#   [ id: 125, ship_to: :TX, net_amount:  24.00 ],
#   [ id: 126, ship_to: :TX, net_amount:  44.80 ],
#   [ id: 127, ship_to: :NC, net_amount:  25.00 ],
#   [ id: 128, ship_to: :MA, net_amount:  10.00 ],
#   [ id: 129, ship_to: :CA, net_amount: 102.00 ],
#   [ id: 120, ship_to: :NC, net_amount:  50.00 ] ]
#   
# Write a function that takes both lists and returns a copy of the orders,
# but with an extra field,  total_amount which is the net plus sales tax. If a
# shipment is not to NC or TX, there’s no tax applied

import Enum

defmodule PragBookshelf do
  def calcTax(tax_rates, orders) do
    map orders, apply_tax_from(tax_rates)
  end
  defp apply_tax_from(tax_rates) do
    fn order -> 
      [_, {:ship_to, state}, {:net_amount, net_amount} ] = order
      {_, tax_rate} = find tax_rates, {:default, 0}, fn r -> elem(r, 0) == state end
      order ++ [total_amount: net_amount * (1 + tax_rate)]
    end
  end
end

tax_rates = [ NC: 0.075, TX: 0.08 ]

orders = [
  [ id: 123, ship_to: :NC, net_amount: 100.00 ],
  [ id: 124, ship_to: :OK, net_amount:  35.50 ], 
  [ id: 125, ship_to: :TX, net_amount:  24.00 ],
  [ id: 126, ship_to: :TX, net_amount:  44.80 ],
  [ id: 127, ship_to: :NC, net_amount:  25.00 ],
  [ id: 128, ship_to: :MA, net_amount:  10.00 ],
  [ id: 129, ship_to: :CA, net_amount: 102.00 ],
  [ id: 120, ship_to: :NC, net_amount:  50.00 ] ]

taxed_orders = [
  [ id: 123, ship_to: :NC, net_amount: 100.00, total_amount: 107.5               ],
  [ id: 124, ship_to: :OK, net_amount:  35.50, total_amount:  35.5               ], 
  [ id: 125, ship_to: :TX, net_amount:  24.00, total_amount:  25.920000000000002 ],
  [ id: 126, ship_to: :TX, net_amount:  44.80, total_amount:  48.384             ],
  [ id: 127, ship_to: :NC, net_amount:  25.00, total_amount:  26.875             ],
  [ id: 128, ship_to: :MA, net_amount:  10.00, total_amount:  10.0               ],
  [ id: 129, ship_to: :CA, net_amount: 102.00, total_amount: 102.0               ],
  [ id: 120, ship_to: :NC, net_amount:  50.00, total_amount:  53.75              ] ]

IO.puts PragBookshelf.calcTax(tax_rates, orders) == taxed_orders


