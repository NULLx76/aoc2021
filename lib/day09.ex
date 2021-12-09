defmodule Aoc2021.Day09 do
  @moduledoc false

  defp parse(file) do
    File.read!(file)
    |> String.split("\n", trim: true)
    |> Enum.map(&String.split(&1, "", trim: true))
    |> Enum.with_index()
    |> Enum.reduce(%{}, fn {line, y}, acc ->
      Enum.with_index(line)
      |> Enum.reduce(%{}, fn {point, x}, acc ->
        Map.put(acc, {x, y}, String.to_integer(point))
      end)
      |> Map.merge(acc)
    end)
  end

  defp neighbours({x, y}),
    do: [
      {x, y + 1},
      {x, y - 1},
      {x + 1, y},
      {x - 1, y}
    ]

  defp get_neighbours(map, point) do
    neighbours(point)
    |> Enum.map(&Map.get(map, &1, false))
    |> Enum.filter(& &1)
  end

  def find_low_points(map) do
    Enum.reduce(map, [], fn {point, el}, acc ->
      if get_neighbours(map, point) |> Enum.all?(&(&1 > el)) do
        [point | acc]
      else
        acc
      end
    end)
  end

  def part1(file \\ "./inputs/day09.txt") do
    map = parse(file)

    find_low_points(map)
    |> Enum.map(&(Map.get(map, &1) + 1))
    |> Enum.sum()
  end

  def find_basins(coords, map, acc \\ [])

  def find_basins([{x, y} = head | tail], map, acc) do
    neighbours(head)
    |> Enum.filter(fn {dx, dy} ->
      Map.get(map, {dx, dy}, -1) > Map.get(map, {x, y}) and Map.get(map, {dx, dy}, -1) < 9
    end)
    |> then(&find_basins(&1 ++ tail, map, [head | acc]))
  end

  def find_basins([], _, acc), do: acc |> Enum.uniq()

  def part2(file \\ "./inputs/day09.txt") do
    map = parse(file)

    find_low_points(map)
    |> Enum.map(&find_basins([&1], map))
    |> Enum.map(&Enum.count/1)
    |> Enum.sort(:desc)
    |> Enum.take(3)
    |> Enum.product()
  end
end
