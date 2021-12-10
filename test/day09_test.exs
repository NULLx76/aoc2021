defmodule Day09Test do
  use ExUnit.Case, async: true

  import Aoc2021.Day09

  test "part1" do
    assert part1() == 494
  end

  test "part2" do
    assert part2() == 1_048_128
  end
end
