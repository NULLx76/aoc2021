defmodule Day06Test do
  use ExUnit.Case, async: true

  import Aoc2021.Day06

  test "part1" do
    assert part1() == 375_482
  end

  test "part2" do
    assert part2() == 1_689_540_415_957
  end
end
