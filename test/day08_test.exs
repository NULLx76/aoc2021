defmodule Day08Test do
  use ExUnit.Case, async: true

  import Aoc2021.Day08

  test "part1" do
    assert part1() == 288
  end

  test "part2" do
    assert part2() == 940724
  end
end
