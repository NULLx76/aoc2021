defmodule Day03Test do
  use ExUnit.Case, async: true

  import Aoc2021.Day03

  test "part1" do
    assert part1() == 3_813_416
  end

  test "part2" do
    assert part2() == 2_990_784
  end
end
