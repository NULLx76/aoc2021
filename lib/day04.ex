defmodule Aoc2021.Day04 do
  @moduledoc false

  defp parse(file) do
    [numbers | boards] = File.read!(file) |> String.split("\n\n", trim: true)

    numbers =
      numbers
      |> String.split(",", trim: true)
      |> Enum.map(&String.to_integer/1)

    boards =
      boards
      |> Enum.map(fn board ->
        board
        |> String.split("\n", trim: true)
        |> Enum.map(fn row ->
          String.split(row, " ", trim: true)
          |> Enum.map(&String.to_integer/1)
          |> Enum.map(&{&1, false})
        end)
      end)

    {numbers, boards}
  end

  def transpose(board) do
    board
    |> List.zip()
    |> Enum.map(&Tuple.to_list/1)
  end

  def has_won?(board) do
    helper = fn board -> Enum.any?(board, &Enum.all?(&1, fn {_, b} -> b end)) end
    helper.(board) or transpose(board) |> helper.()
  end

  def calculate_score(board, num) do
    board
    |> List.flatten()
    |> Enum.filter(fn {_, b} -> !b end)
    |> Enum.map(fn {a, _} -> a end)
    |> Enum.sum()
    |> then(&(&1 * num))
  end

  def tick_numbers(boards, x) do
    Enum.map(
      boards,
      &Enum.map(&1, fn row ->
        Enum.map(row, fn
          {^x, _} -> {x, true}
          c -> c
        end)
      end)
    )
  end

  def step1([x | xs], boards) do
    boards = tick_numbers(boards, x)

    case Enum.find(boards, nil, &has_won?/1) do
      nil -> step1(xs, boards)
      win -> calculate_score(win, x)
    end
  end

  def part1(file \\ "./inputs/day04.txt") do
    {nums, boards} = parse(file)
    step1(nums, boards)
  end

  def step2([x | xs], boards) do
    boards =
      tick_numbers(boards, x)
      |> Enum.reject(&has_won?/1)

    case boards do
      [b] -> step1(xs, [b])
      bs -> step2(xs, bs)
    end
  end

  def part2(file \\ "./inputs/day04.txt") do
    {nums, boards} = parse(file)
    step2(nums, boards)
  end
end
