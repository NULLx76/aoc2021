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

  def get_average(list) do
    Enum.sum(list)
    |> div(length(list))
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

  def part2(file \\ "./inputs/day07.txt") do
    list = parse(file)
    avg = get_average(list)

    calculate_cost_p2(list, avg)
    |> min(calculate_cost_p2(list, avg + 1))
    |> min(calculate_cost_p2(list, avg - 1))
  end

  def gradient(list, pos, dx, curr_cost) do
    next = calculate_cost_p2(list, pos + dx)
    if curr_cost < next, do: curr_cost, else: gradient(list, pos + dx, dx, next)
  end

  @doc """
  This is my orginal solution for part2 that instead of just taking the average
  uses the median as a starting point for doing gradient descent
  """
  def part2_gradient(file \\ "./inputs/day07.txt") do
    list = Enum.sort(parse(file))
    median = get_median(list)

    curr = calculate_cost_p2(list, median)
    left = calculate_cost_p2(list, median - 1)
    right = calculate_cost_p2(list, median + 1)

    cond do
      curr < min(left, right) -> curr
      left < right -> gradient(list, median - 1, -1, left)
      right < left -> gradient(list, median + 1, +1, right)
    end
  end
end
