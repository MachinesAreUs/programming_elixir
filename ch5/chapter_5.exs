# 5.1 Functions and pattern matching

# list_concat: 1st try

list_concat = fn [h1|t1], [h2|t2] -> List.flatten [h1,t1,h2,t2] end
IO.puts list_concat.([1,2,3],[4,5,6]) == [1, 2, 3, 4, 5, 6]

# list_concat: 2nd try
 
list_concat = fn a, b -> a ++ b end
IO.puts list_concat.([1,2,3],[4,5,6]) == [1, 2, 3, 4, 5, 6]

# sum 3 values

sum = fn a, b, c -> a + b + c end
IO.puts sum.(1,2,3) == 6

# pair_tuple_to_list

pair_tuple_to_list = fn {a, b} -> [a, b] end
IO.puts pair_tuple_to_list.( { 8, 7 } ) == [ 8, 7 ] 

# 5.2 One Function, Multiple Bodies

fizz_buzz_disc = function do
  0, 0, _ -> "FizzBuzz"
  0, _, _ -> "Fizz"
  _, 0, _ -> "Buzz"
  _, _, x -> x
end 

IO.puts fizz_buzz_disc.(0, 0, 1) == "FizzBuzz"
IO.puts fizz_buzz_disc.(0, 1, 1) == "Fizz"
IO.puts fizz_buzz_disc.(1, 0, 1) == "Buzz"
IO.puts fizz_buzz_disc.(1, 1, 1) == 1

fizz_buzz = function do
	n -> fizz_buzz_disc.(rem(n,3), rem(n, 5), n)
end

IO.puts (Enum.map 10..16, fizz_buzz.(&1)) == ["Buzz", 11, "Fizz", 13, 14, "FizzBuzz", 16]

# 5.3 Functions Can Return Functions

prefix = fn s1 -> (fn s2 -> "#{s1} #{s2}" end) end
IO.puts prefix.("hola").("mundo") == "hola mundo"

# 5.4 Passing Functions as Arguments

# list_concat: 3rd try

list_concat = &1 ++ &2
IO.puts list_concat.([1,2,3],[4,5,6]) == [1, 2, 3, 4, 5, 6]

# suma and pair_tuple_to_lista are not suitable excercises 
# as noted in http://pragprog.com/titles/elixir/errata #51577

