defmodule Aoc2021.Day13 do
  @moduledoc false

  defp parse(file) do
    [coords, instructions] =
      File.read!(file)
      |> String.split("\n\n", trim: true)

    coords =
      coords
      |> String.split("\n", trim: true)
      |> Enum.map(fn coord ->
        String.split(coord, ",", trim: true)
        |> Enum.map(&String.to_integer/1)
        |> List.to_tuple()
      end)
      |> MapSet.new()

    instructions =
      instructions
      |> String.split("\n", trim: true)
      |> Enum.map(fn
        "fold along x=" <> i -> {0, String.to_integer(i)}
        "fold along y=" <> i -> {1, String.to_integer(i)}
      end)

    {coords, instructions}
  end

  def fold({dir, fold}, coords) do
    MapSet.new(coords, fn
      coord when elem(coord, dir) > fold -> put_elem(coord, dir, fold - (elem(coord, dir) - fold))
      coord -> coord
    end)
  end

  def part1(file \\ "./inputs/day13.txt") do
    {coords, [instr | _]} = parse(file)
    fold(instr, coords)
    |> MapSet.size()
  end

  def print(set) do
    {max_x, _} = Enum.max_by(set, &elem(&1, 0))
    {_, max_y} = Enum.max_by(set, &elem(&1, 1))

    Enum.map_join(0..max_y, "\n", fn y ->
      Enum.map_join(0..max_x, &if({&1, y} in set, do: "█", else: " "))
    end)
  end

  def part2(file \\ "./inputs/day13.txt") do
    {coords, instrs} = parse(file)
    text = instrs |> Enum.reduce(coords, &fold/2) |> print()
    "\n#{text}"
  end
end
