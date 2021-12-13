defmodule Day13Test do
  use ExUnit.Case, async: true

  import Aoc2021.Day13

  test "part1" do
    assert part1() == 592
  end

  test "part2" do
    assert part2() == "\n  ██  ██   ██    ██ ████ ████ █  █ █  █\n   █ █  █ █  █    █ █    █    █ █  █  █\n   █ █    █  █    █ ███  ███  ██   █  █\n   █ █ ██ ████    █ █    █    █ █  █  █\n█  █ █  █ █  █ █  █ █    █    █ █  █  █\n ██   ███ █  █  ██  ████ █    █  █  ██ "
  end
end
