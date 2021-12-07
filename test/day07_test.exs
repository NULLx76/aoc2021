defmodule Day07Test do
  use ExUnit.Case, async: true

  import Aoc2021.Day07

  test "part1" do
    assert part1() == 357353
  end

  test "part2" do
    assert part2() == 104822130
  end
end
