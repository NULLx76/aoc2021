defmodule Day10Test do
  use ExUnit.Case, async: true

  import Aoc2021.Day10

  test "part1" do
    assert part1() == 323613
  end

  test "part2" do
    assert part2() == 3103006161
  end
end
