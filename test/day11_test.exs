defmodule Day11Test do
  use ExUnit.Case, async: true

  import Aoc2021.Day11

  test "part1" do
    assert part1() == 1713
  end

  test "part2" do
    assert part2() == 502
  end
end
