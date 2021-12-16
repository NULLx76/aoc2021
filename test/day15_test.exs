defmodule Day15Test do
  use ExUnit.Case, async: true

  import Aoc2021.Day15

  test "part1" do
    assert part1() == 472
  end

  test "part2" do
    assert part2() == 2851
  end
end
