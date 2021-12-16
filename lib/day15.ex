defmodule Aoc2021.Day15 do
  @moduledoc false

  defp parse(file) do
    lines = File.read!(file) |> String.split("\n", trim: true)

    for {col, y} <- Enum.with_index(lines),
        {row, x} <- Enum.with_index(String.graphemes(col)),
        into: %{} do
      {{x, y}, String.to_integer(row)}
    end
  end

  def make_graph(grid) do
    Enum.reduce(grid, Graph.new(), fn {{x, y}, _}, graph ->
      nbs =
        [{x - 1, y}, {x + 1, y}, {x, y - 1}, {x, y + 1}]
        |> Enum.map(fn point -> {{x, y}, point, [weight: Map.get(grid, point, false)]} end)
        |> Enum.filter(fn {_, _, [weight: w]} -> w end)

      Graph.add_edges(graph, nbs)
    end)
  end

  def part1(file \\ "./inputs/day15.txt") do
    grid = parse(file)
    graph = make_graph(grid)
    start = {0, 0}
    finish = grid |> Map.keys() |> Enum.max()

    graph
    |> Graph.dijkstra(start, finish)
    |> Enum.drop(1)
    |> Enum.map(&Map.get(grid, &1))
    |> Enum.sum()
  end

  def expand_grid(grid) do
    max = grid |> Map.keys() |> Enum.max()

    Enum.flat_map(grid, fn point ->
      for x <- 0..4, y <- 0..4, {x, y} != {0, 0} do
        replicate_point(point, {x, y}, max)
      end
    end)
    |> Enum.into(grid)
  end

  def replicate_point({{x, y}, w}, {x1, y1}, {max_y, max_x}) do
    w = w + x1 + y1
    w = if w > 9, do: rem(w, 9), else: w
    x = x + (max_x + 1) * x1
    y = y + (max_y + 1) * y1

    {{x, y}, w}
  end

  @doc """
  See this libgraph issue: https://github.com/bitwalker/libgraph/issues/44
  """
  def part2(file \\ "./inputs/day15.txt") do
    grid = parse(file) |> expand_grid()
    graph = make_graph(grid)
    start = {0, 0}
    finish = grid |> Map.keys() |> Enum.max()

    graph
    |> Graph.dijkstra(start, finish)
    |> Enum.drop(1)
    |> Enum.map(&Map.get(grid, &1))
    |> Enum.sum()
  end
end
