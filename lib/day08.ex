defmodule Aoc2021.Day08 do
  @moduledoc false

  defp parse(file) do
    File.read!(file)
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      String.split(line, "|", trim: true)
      |> Enum.map(&String.split(&1, " ", trim: true))
      |> List.to_tuple()
    end)
  end

  def is_1478?(chars), do: String.length(chars) in [2, 4, 3, 7]

  def part1(file \\ "./inputs/day08.txt") do
    parse(file)
    |> Enum.map(&elem(&1, 1))
    |> Enum.map(&Enum.filter(&1, fn e -> is_1478?(e) end))
    |> Enum.map(&Enum.count/1)
    |> Enum.sum()
  end

  def deduce_number(code, _) when length(code) == 2, do: 1
  def deduce_number(code, _) when length(code) == 3, do: 7
  def deduce_number(code, _) when length(code) == 4, do: 4
  def deduce_number(code, _) when length(code) == 7, do: 8

  def deduce_number(chars, input) do
    one = Enum.find(input, &(String.length(&1) == 2)) |> String.to_charlist()
    four = Enum.find(input, &(String.length(&1) == 4)) |> String.to_charlist()

    case length(chars) do
      5 ->
        cond do
          length(chars -- one) == 3 -> 3
          length(chars -- four) == 3 -> 2
          true -> 5
        end

      6 ->
        cond do
          length(chars -- one) == 5 -> 6
          length(chars -- four) == 2 -> 9
          true -> 0
        end
    end
  end

  def process_line({input, output}) do
    output
    |> Enum.map(&String.to_charlist/1)
    |> Enum.map(&deduce_number(&1, input))
    |> Integer.undigits()
  end

  def part2(file \\ "./inputs/day08.txt") do
    parse(file)
    |> Enum.map(&process_line/1)
    |> Enum.sum()
  end
end
