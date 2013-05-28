# 7.6 More Complex List Patterns

defmodule WeatherHistory do

  def for_location([], _target_loc), do: []
  def for_location( [ h = [_, loc, _, _] | t ], target_loc)
  when loc == target_loc do
    [ h | for_location(t, target_loc) ]
  end
  def for_location( [ _ | t ], target_loc) do
    for_location t, target_loc
  end

  def test_data do
    [
      [1366225622, 26, 15, 0.125],
      [1366225622, 27, 15, 0.45],
      [1366225622, 12, 21, 0.25],
      [1366229222, 26, 19, 0.081],
      [1366229222, 27, 17, 0.468],
      [1366229222, 28, 15, 0.60],
      [1366232822, 12, 22, 0.095],
      [1366232822, 13, 21, 0.05],
      [1366232822, 28, 24, 0.03],
      [1366236422, 26, 17, 0.025]
    ]
  end

end

import WeatherHistory

IO.puts for_location(test_data, 13) == [[1366232822,13,21,0.050000000000000003]]
IO.puts for_location(test_data, 12) == 
  [
    [1366225622,12,21,0.25],
    [1366232822,12,22,0.095000000000000001]
  ]