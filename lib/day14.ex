defmodule Aoc2021.Day14 do
  @moduledoc false

  defp parse(file) do
    [poly, rules] = File.read!(file) |> String.split("\n\n", trim: true)

    poly =
      poly
      |> String.graphemes()
      |> Enum.chunk_every(2, 1, :discard)
      |> Enum.map(&List.to_tuple/1)

    # Save the first element for later
    fst = poly |> hd() |> elem(0)

    rules =
      rules
      |> String.split("\n", trim: true)
      |> Map.new(fn entry ->
        [l, r] = String.split(entry, " -> ", trim: true)
        {String.graphemes(l) |> List.to_tuple(), r}
      end)

    {Enum.frequencies(poly), rules, fst}
  end

  def step(poly, _, 0), do: poly

  def step(poly, rules, count) do
    Enum.reduce(poly, %{}, fn
      {{l, r} = pair, x}, acc when is_map_key(rules, pair) ->
        c = rules[pair]

        Map.update(acc, {l, c}, x, &(&1 + x))
        |> Map.update({c, r}, x, &(&1 + x))

      _, acc ->
        acc
    end)
    |> step(rules, count - 1)
  end

  defp calc_answer(poly, fst) do
    Enum.reduce(poly, %{}, fn {{_, r}, n}, acc ->
      Map.update(acc, r, n, &(&1 + n))
    end)
    |> Map.update!(fst, &(&1 + 1))
    |> Map.values()
    |> Enum.min_max()
    |> then(fn {min, max} -> max - min end)
  end

  def part1(file \\ "./inputs/day14.txt") do
    {poly, rules, fst} = parse(file)
    step(poly, rules, 10)
    |> calc_answer(fst)
  end

  def part2(file \\ "./inputs/day14.txt") do
    {poly, rules, fst} = parse(file)
    step(poly, rules, 40)
    |> calc_answer(fst)
  end
end
