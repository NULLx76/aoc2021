defmodule Aoc2021.Day01 do
  defp parse(file) do
    File.read!(file)
    |> String.split("\n", trim: true)
    |> Enum.map(&String.to_integer/1)
  end

  defp reduce(el, {prev, acc}) when el > prev, do: {el, acc + 1}
  defp reduce(el, {_, acc}), do: {el, acc}

  def part1(file \\ "./inputs/day01.txt") do
    {_, count} =
      parse(file)
      |> Enum.reduce({0, 0}, &reduce/2)

    count - 1
  end

  def part2(file \\ "./inputs/day01.txt") do
    {_, count} =
      parse(file)
      |> Enum.chunk_every(3, 1)
      |> Enum.map(&Enum.sum/1)
      |> Enum.reduce({0, 0}, &reduce/2)

    count - 1
  end
end
