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

  defp helper_has_won?(board) do
    Enum.any?(board, fn row ->
      Enum.all?(row, fn {_, b} -> b end)
    end)
  end

  def has_won?(board), do: helper_has_won?(board) or helper_has_won?(transpose(board))

  def calculate_score(board, num) do
    Enum.reduce(board, 0, fn row, acc ->
      Enum.filter(row, fn {_, b} -> !b end)
      |> Enum.map(fn {a, _} -> a end)
      |> Enum.sum()
      |> then(&(&1 + acc))
    end)
    |> then(&(&1 * num))
  end

  def step1([x | xs], boards) do
    boards =
      boards
      |> Enum.map(
        &Enum.map(&1, fn row ->
          Enum.map(row, fn
            {^x, _} -> {x, true}
            c -> c
          end)
        end)
      )

    if win = Enum.find(boards, nil, &has_won?/1) do
      calculate_score(win, x)
    else
      step1(xs, boards)
    end
  end

  def part1(file \\ "./inputs/day04.txt") do
    {nums, boards} = parse(file)
    step1(nums, boards)
  end


  def step2([x | xs], boards) do
    boards =
      boards
      |> Enum.map(
        &Enum.map(&1, fn row ->
          Enum.map(row, fn
            {^x, _} -> {x, true}
            c -> c
          end)
        end)
      )
      |> Enum.reject(&has_won?/1)

    case boards do
      [b] -> calculate_score(b, x)
      bs-> step2(xs, bs)
    end
  end

  def part2(file \\ "./inputs/day04_example.txt") do
    {nums, boards} = parse(file)
    step2(nums, boards)
  end
end
