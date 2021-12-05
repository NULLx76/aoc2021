defmodule Aoc2021.Day05 do
  @moduledoc false

  defp parse(file) do
    File.read!(file)
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      line
      |> String.split(" -> ", trim: true)
      |> Enum.map(&String.split(&1, ","))
      |> Enum.map(fn [a, b] -> {String.to_integer(a), String.to_integer(b)} end)
    end)
    |> Enum.map(&List.to_tuple/1)
  end

  def gen_points({{x1, y1}, {x2, y2}}) when x1 == x2 or y1 == y2 do
    for x <- x1..x2, y <- y1..y2, do: {x, y}
  end

  def gen_points({{x1, y1}, {x2, y2}}) do
    xs = x1..x2//if(x1 < x2, do: 1, else: -1)
    ys = y1..y2//if(y1 < y2, do: 1, else: -1)
    Enum.zip(xs, ys)
  end

  def count_crossings(coords) do
    coords
    |> Enum.flat_map(&gen_points/1)
    |> Enum.frequencies()
    |> Enum.filter(fn {_, f} -> f > 1 end)
    |> Enum.count()
  end

  def part1(file \\ "./inputs/day05.txt") do
    parse(file)
    |> Enum.filter(fn {{x1, y1}, {x2, y2}} -> x1 == x2 or y1 == y2 end)
    |> count_crossings()
  end

  def part2(file \\ "./inputs/day05.txt") do
    parse(file)
    |> count_crossings()
  end
end
