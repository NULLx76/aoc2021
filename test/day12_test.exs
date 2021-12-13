defmodule Day12Test do
  use ExUnit.Case, async: true

  import Aoc2021.Day12

  test "part1" do
    assert part1() == 3738
  end

  test "part2" do
    assert part2() == 120506
  end
end
