defmodule Day14Test do
  use ExUnit.Case, async: true

  import Aoc2021.Day14

  test "part1" do
    assert part1() == 2003
  end

  test "part2" do
    assert part2() == 2276644000111
  end
end
