defmodule Aoc2021.Day11 do
  @moduledoc false

  @deltas [
    {-1, -1},
    {-1, 0},
    {-1, 1},
    {0, 1},
    {1, 1},
    {1, 0},
    {1, -1},
    {0, -1}
  ]

  defp parse(file) do
    lines = File.read!(file) |> String.split("\n", trim: true)

    for {line, row} <- Enum.with_index(lines),
        {num, col} <- Enum.with_index(String.graphemes(line)),
        into: %{} do
      {{row, col}, String.to_integer(num)}
    end
  end

  def flash({x, y}, octos) do
    @deltas
    |> Enum.map(fn {dx, dy} -> {x + dx, y + dy} end)
    |> Enum.reduce(octos, &advance_energy/2)
  end

  def advance_energy(position, octos) do
    case Map.get(octos, position) do
      nil -> octos
      9 -> flash(position, Map.put(octos, position, 10))
      n -> Map.put(octos, position, n + 1)
    end
  end

  defp count_flashes(octos) do
    Map.values(octos)
    |> Enum.count(&(&1 == 0))
  end

  defp step(octos) do
    Map.keys(octos)
    |> Enum.reduce(octos, &advance_energy/2)
    |> Map.new(fn
      {pos, n} when n > 9 -> {pos, 0}
      el -> el
    end)
  end

  def step_and_count(octos, count \\ 0, step \\ 100)
  def step_and_count(_, c, 0), do: c

  def step_and_count(octos, count, step) do
    octos = octos |> step()
    step_and_count(octos, count + count_flashes(octos), step - 1)
  end

  def part1(file \\ "./inputs/day11.txt") do
    parse(file)
    |> step_and_count()
  end

  def find_full_flash(octos), do: find_full_flash(octos, 1)

  def find_full_flash(octos, step) do
    octos = octos |> step()

    case count_flashes(octos) do
      100 -> step
      _ -> find_full_flash(octos, step + 1)
    end
  end

  def part2(file \\ "./inputs/day11.txt") do
    parse(file)
    |> find_full_flash()
  end
end
