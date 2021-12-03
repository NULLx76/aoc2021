defmodule Aoc2021.Day01 do
  @moduledoc false

  defp parse(file) do
    File.read!(file)
    |> String.split("\n", trim: true)
    |> Enum.map(&String.to_integer/1)
  end

  def part1(file \\ "./inputs/day01.txt") do
    parse(file)
    |> Stream.chunk_every(2, 1, :discard)
    |> Enum.count(fn [a, b] -> b > a end)
  end

  def part2(file \\ "./inputs/day01.txt") do
    parse(file)
    |> Enum.chunk_every(3, 1)
    |> Enum.map(&Enum.sum/1)
    |> Stream.chunk_every(2, 1, :discard)
    |> Enum.count(fn [a, b] -> b > a end)
  end
end
