
# Write a function flatten(list)that takes a list that may contain any
# number of sublists, and those sublists may contain sublists, to any
# depth. It returns the elements of these lists as a flat list.

defmodule MyList do
  
  def flatten([]), do: []

  def flatten( [ h | [] ] ) 
  when is_list(h), do: flatten h

  def flatten( [ h | [] ] ) 
  when not is_list(h), do: [h]

  def flatten( [ h | t ] ) 
  when not is_list(h) do
    [ h | flatten(t) ]
  end

  def flatten( [ h | t ] )
  when is_list(h) do
    flatten(h) ++ flatten(t)
  end

end

IO.puts MyList.flatten( [] )                             == []
IO.puts MyList.flatten( [1] )                            == [1]
IO.puts MyList.flatten( [[[1]]] )                        == [1]
IO.puts MyList.flatten( [1, 2, 3] )                      == [1, 2, 3]
IO.puts MyList.flatten( [1, [2, 3]] )                    == [1, 2, 3]
IO.puts MyList.flatten( [1, [2, [3]]] )                  == [1, 2, 3]
IO.puts MyList.flatten( [ 1, [ 2, 3, [4]], 5, [[[6]]]] ) == [1,2,3,4,5,6]

