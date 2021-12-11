defmodule Mix.Tasks.Aoc do
  @shortdoc "print aoc days"
  @moduledoc "This tasks run all or specific days and prints them"

  use Mix.Task

  @spec pad_zero(integer()) :: binary()
  def pad_zero(day) do
    if day < 10 do
      "0" <> Integer.to_string(day)
    else
      Integer.to_string(day)
    end
  end

  def run_day(day) do
    mod = "Elixir.Aoc2021.Day" <> pad_zero(day)

    atom =
      try do
        String.to_existing_atom(mod)
      rescue
        ArgumentError -> reraise "Invalid Day", __STACKTRACE__
      end

    Mix.shell().info("Day #{day}:")
    Mix.shell().info(" p1: #{apply(atom, :part1, [])}")
    Mix.shell().info(" p2: #{apply(atom, :part2, [])}")
  end

  @impl Mix.Task
  def run(args) do
    if length(args) == 1 do
      case Integer.parse(hd(args)) do
        {day, _} ->
          run_day(day)

        :error ->
          Mix.shell().error("Invalid integer: \"#{hd(args)}\"")
      end
    else
      for x <- 1..25, do: run_day(x)
    end
  end
end
