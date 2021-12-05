defmodule Day04Test do
  use ExUnit.Case, async: true

  import Aoc2021.Day04

  test "part1" do
    assert part1() == 58412
  end

  test "part2" do
    assert part2() == 10030
  end
end
