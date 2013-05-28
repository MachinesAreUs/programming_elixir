# 6.4 Default Parameters

defmodule Chop do

  def guess(n, min..max) when n >= min and n <= max do
    do_guess n, half_from(min, max), min..max
  end
  
  def do_guess(n, n, _min.._max) do
    IO.puts "It's #{n}!"
  end 
  
  def do_guess(n, guess, min..max) when n > guess do
    IO.puts "Is it #{guess}"
    do_guess n, half_from(guess, max), guess..max
  end
  
  def do_guess(n, guess, min..max) when n < guess do
    IO.puts "Is it #{guess}"
    do_guess n, half_from(min, guess), min..guess
  end

  def half_from(min, max), do: min + div(max-min, 2)

end