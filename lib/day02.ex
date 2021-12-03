defmodule Aoc2021.Day02 do
  defp parse(file) do
    File.read!(file)
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      [dir, num] = String.split(line)
      {dir, String.to_integer(num)}
    end)
  end

  def move_p1(_, pos \\ {0, 0})
  def move_p1([], {x, y}), do: x * y
  def move_p1([{"forward", amount} | tail], {x, y}), do: move_p1(tail, {x + amount, y})
  def move_p1([{"up", amount} | tail], {x, y}), do: move_p1(tail, {x, y - amount})
  def move_p1([{"down", amount} | tail], {x, y}), do: move_p1(tail, {x, y + amount})

  def part1(file \\ "./inputs/day02.txt") do
    parse(file)
    |> move_p1()
  end

  def move_p2(_, pos \\ {0, 0, 0})
  def move_p2([], {x, y, _}), do: x * y
  def move_p2([{"forward", amount} | tail], {x, y, aim}), do: move_p2(tail, {x + amount, y + amount * aim, aim})
  def move_p2([{"up", amount} | tail], {x, y, aim}), do: move_p2(tail, {x, y, aim - amount})
  def move_p2([{"down", amount} | tail], {x, y, aim}), do: move_p2(tail, {x, y, aim + amount})

  def part2(file \\ "./inputs/day02.txt") do
    parse(file)
    |> move_p2()
  end
end
