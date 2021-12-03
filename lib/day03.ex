defmodule Aoc2021.Day03 do
  import Nx.Defn

  defp parse(file) do
    File.read!(file)
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      line
      |> String.graphemes()
      |> Enum.map(&String.to_integer/1)
    end)
  end

  @spec flip([0 | 1]) :: [0 | 1]
  def flip(n) do
    Enum.map(n, fn
      1 -> 0
      0 -> 1
    end)
  end

  defn nx_find_most_common(t) do
    t
    |> Nx.mean(axes: [0])
    |> Nx.round()
  end

  def find_most_common(input) do
    input
    |> Nx.tensor()
    |> nx_find_most_common
    |> Nx.to_flat_list()
    |> Enum.map(&trunc/1)
  end

  def part1(file \\ "./inputs/day03.txt") do
    num =
      parse(file)
      |> find_most_common()

    [num, flip(num)]
    |> Enum.map(&Integer.undigits(&1, 2))
    |> Enum.reduce(&(&1 * &2))
  end

  def oxygen(_, [x], _), do: x
  def oxygen(common, input, pos) do
    step =
      input
      |> Enum.reduce([], fn el, acc ->
        if Enum.at(el, pos) == Enum.at(common, pos) do
          [el | acc]
        else
          acc
        end
      end)

    oxygen(find_most_common(step), step, pos + 1)
  end

  def scrubber(_, [x], _), do: x
  def scrubber(common, input, pos) do
    step =
      input
      |> Enum.reduce([], fn el, acc ->
        if Enum.at(el, pos) != Enum.at(common, pos) do
          [el | acc]
        else
          acc
        end
      end)

    scrubber(find_most_common(step), step, pos + 1)
  end

  def part2(file \\ "./inputs/day03.txt") do
    input = parse(file)
    common = find_most_common(input)
    # Oxygen
    a =
      oxygen(common, input, 0)
      |> Integer.undigits(2)

    b =
      scrubber(common, input, 0)
      |> Integer.undigits(2)

    a * b
  end
end
