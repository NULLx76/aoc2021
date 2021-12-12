defmodule Aoc2021.Day12 do
  @moduledoc false

  defp parse(file) do
    File.read!(file)
    |> String.split("\n", trim: true)
    |> Enum.map(&(String.split(&1, "-") |> List.to_tuple()))
    |> Enum.reduce(%{}, fn {from, to}, graph ->
      graph
      |> Map.update(from, [to], fn neighbors -> [to | neighbors] end)
      |> Map.update(to, [from], fn neighbors -> [from | neighbors] end)
    end)
  end

  defp upcase?(s), do: s == String.upcase(s)

  defp count(g, twice?), do: count(g, twice?, "start", ["start"], 0)
  defp count(_, _, "end", _, count), do: count + 1
  defp count(g, twice?, v, visited, count), do: traverse(Map.get(g, v, []), visited, g, twice?, count)

  defp traverse([], _, _, _, count), do: count

  defp traverse([head | tail], visited, g, twice?, count) do
    cond do
      upcase?(head) or head not in visited ->
        traverse(tail, visited, g, twice?, count + count(g, twice?, head, [head | visited], 0))

      head not in ["start", "end"] and twice? ->
        traverse(tail, visited, g, twice?, count + count(g, false, head, [head | visited], 0))

      true ->
        traverse(tail, visited, g, twice?, count)
    end
  end

  def part1(file \\ "./inputs/day12.txt") do
    parse(file)
    |> count(false)
  end

  def part2(file \\ "./inputs/day12.txt") do
    parse(file)
    |> count(true)
  end
end
