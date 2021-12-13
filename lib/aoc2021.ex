defmodule Aoc2021 do
  @moduledoc """
  My 2021 Advent of Code solutions
  """

  def benchmark(function) do
    function
    |> :timer.tc()
    |> elem(0)
    |> then(&(&1 / 1000))
  end
end
