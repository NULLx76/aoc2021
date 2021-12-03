defmodule Aoc2021.Day03 do
  @moduledoc false

  defp parse(file) do
    File.read!(file)
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      line
      |> String.graphemes()
      |> Enum.map(&String.to_integer/1)
    end)
  end

  defp flip(n) do
    Enum.map(n, fn
      1 -> 0
      0 -> 1
    end)
  end

  def find_most_common(input) do
    input
    |> Nx.tensor()
    |> Nx.mean(axes: [0])
    |> Nx.round()
    |> Nx.to_flat_list()
    |> Enum.map(&trunc/1)
  end

  def part1(file \\ "./inputs/day03.txt") do
    num =
      parse(file)
      |> find_most_common()

    [num, flip(num)]
    |> Enum.map(&Integer.undigits(&1, 2))
    |> then(fn [a, b] -> a * b end)
  end

  def life_support(_, _, _ \\ 0)
  def life_support([x], _, _), do: Integer.undigits(x, 2)

  def life_support(input, type, pos) do
    common = find_most_common(input)

    Enum.filter(input, fn el ->
      match = Enum.at(el, pos) == Enum.at(common, pos)
      if type == :oxygen, do: match, else: !match
    end)
    |> life_support(type, pos + 1)
  end

  def part2(file \\ "./inputs/day03.txt") do
    input = parse(file)
    life_support(input, :oxygen) * life_support(input, :scrubber)
  end
end
