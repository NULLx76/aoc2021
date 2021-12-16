defmodule Day16Test do
  use ExUnit.Case, async: true

  import Aoc2021.Day16

  test "part1" do
    assert part1() == 901
  end

  test "part2" do
    assert part2() == 110434737925
  end
end
