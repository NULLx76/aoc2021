defmodule Day05Test do
  use ExUnit.Case, async: true

  import Aoc2021.Day05

  test "part1" do
    assert part1() == 5169
  end

  test "part2" do
    assert part2() == 22083
  end
end

