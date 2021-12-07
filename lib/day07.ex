defmodule Aoc2021.Day07 do
  @moduledoc false

  defp parse(file) do
    File.read!(file)
    |> String.split([",", "\n"], trim: true)
    |> Enum.map(&String.to_integer/1)
  end

  def get_median(list) do
    index = list |> length() |> div(2)
    Enum.at(list, index)
  end

  def calculate_cost_p1(list, pos) do
    Enum.map(list, &abs(&1 - pos))
    |> Enum.sum()
  end

  def part1(file \\ "./inputs/day07.txt") do
    list = Enum.sort(parse(file))
    median = get_median(list)
    calculate_cost_p1(list, median)
  end

  def calculate_cost_p2(list, pos) do
    Enum.map(list, fn orig ->
      n = abs(orig - pos)
      trunc(n * (n + 1) / 2)
    end)
    |> Enum.sum()
  end

  def step(list, pos, dx, curr_cost) do
    next = calculate_cost_p2(list, pos + dx)

    if curr_cost < next do
      curr_cost
    else
      step(list, pos + dx, dx, next)
    end
  end

  def part2(file \\ "./inputs/day07.txt") do
    list = Enum.sort(parse(file))
    median = get_median(list)

    curr = calculate_cost_p2(list, median)
    left = calculate_cost_p2(list, median - 1)
    right = calculate_cost_p2(list, median + 1)

    if curr < min(left, right) do
      curr
    else
      if left < right do
        step(list, median - 1, -1, left)
      else
        step(list, median + 1, +1, right)
      end
    end
  end
end
