defmodule Day06Test do
  use ExUnit.Case, async: true

  import Aoc2021.Day06

  test "part1" do
    assert part1() == 375482
  end

  test "part2" do
    assert part2() == 1689540415957
  end
end
