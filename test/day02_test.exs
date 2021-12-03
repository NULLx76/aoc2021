defmodule Day02Test do
  use ExUnit.Case, async: true

  import Aoc2021.Day02

  test "part1" do
    assert part1() == 1_938_402
  end

  test "part2" do
    assert part2() == 1_947_878_632
  end
end
