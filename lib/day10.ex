defmodule Aoc2021.Day10 do
  @moduledoc false

  alias Aoc2021.Day07

  defp parse(file) do
    File.read!(file)
    |> String.split("\n", trim: true)
    |> Enum.map(&String.graphemes/1)
  end

  def check_line(_, _ \\ [])
  def check_line([], acc), do: {:incomplete, acc}
  def check_line([head | tail], acc) when head in ["[", "{", "<", "("], do: check_line(tail, [head | acc])
  def check_line(["]" | tail], ["[" | acc]), do: check_line(tail, acc)
  def check_line(["}" | tail], ["{" | acc]), do: check_line(tail, acc)
  def check_line([">" | tail], ["<" | acc]), do: check_line(tail, acc)
  def check_line([")" | tail], ["(" | acc]), do: check_line(tail, acc)
  def check_line([head | _], _), do: {:corrupted, head}

  def part1(file \\ "./inputs/day10.txt") do
    parse(file)
    |> Enum.map(&check_line/1)
    |> Enum.map(fn
      {:incomplete, _} -> 0
      {:corrupted, ")"} -> 3
      {:corrupted, "]"} -> 57
      {:corrupted, "}"} -> 1197
      {:corrupted, ">"} -> 25_137
    end)
    |> Enum.sum()
  end

  def p2_score({:incomplete, line}) do
    Enum.reduce(line, 0, fn
      "(", acc -> acc * 5 + 1
      "[", acc -> acc * 5 + 2
      "{", acc -> acc * 5 + 3
      "<", acc -> acc * 5 + 4
    end)
  end

  def part2(file \\ "./inputs/day10.txt") do
    parse(file)
    |> Enum.map(&check_line/1)
    |> Enum.reject(&(elem(&1, 0) == :corrupted))
    |> Enum.map(&p2_score/1)
    |> Enum.sort()
    |> Day07.get_median()
  end
end
