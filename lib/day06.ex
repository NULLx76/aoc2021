defmodule Aoc2021.Day06 do
  @moduledoc false

  defp parse(file) do
    File.read!(file)
    |> String.split([",", "\n"], trim: true)
    |> Enum.map(&String.to_integer/1)
    |> Enum.frequencies()
  end

  def step(fish, 0), do: fish |> Map.values() |> Enum.sum()

  def step(fish, day) do
    Enum.reduce(fish, %{}, fn
      {0, num}, acc ->
        Map.put(acc, 8, num)
        |> Map.update(6, num, &(&1 + num))

      {t, num}, acc ->
        Map.update(acc, t - 1, num, &(&1 + num))
    end)
    |> step(day - 1)
  end

  def part1(file \\ "./inputs/day06.txt") do
    parse(file)
    |> step(80)
  end

  def part2(file \\ "./inputs/day06.txt") do
    parse(file)
    |> step(256)
  end
end
