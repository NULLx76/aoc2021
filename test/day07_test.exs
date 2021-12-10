defmodule Day07Test do
  use ExUnit.Case, async: true

  import Aoc2021.Day07

  test "part1" do
    assert part1() == 357_353
  end

  test "part2" do
    assert part2() == 104_822_130
    assert part2_gradient() == 104_822_130
  end
end
