defmodule Day01Test do
  use ExUnit.Case, async: true

  import Aoc2021.Day01

  test "part1" do
    assert part1() == 1616
  end

  test "part2" do
    assert part2() == 1645
  end
end
