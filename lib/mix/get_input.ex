defmodule Mix.Tasks.GetInput do
  @shortdoc "Download AoC Input file"
  @moduledoc "This tasks downloads the Advent of Code input using a provided cookie in `./.aoc_cookie` of the current or a provided day"

  use Mix.Task

  def run([]), do: run(["#{DateTime.utc_now().day}"])

  @impl Mix.Task
  def run([day]) do
    :ok = Application.ensure_started(:erqwest)
    :ok = :erqwest.start_client(:default)

    day = String.to_integer(day)

    cookie = File.read!("./.aoc_cookie") |> String.trim()

    {:ok, %{status: 200, body: body}} =
      :erqwest.get(:default, "https://adventofcode.com/2021/day/#{day}/input", %{headers: [{"Cookie", cookie}]})

    padded_day = Mix.Tasks.Aoc.pad_zero(day)
    :ok = File.write!("./inputs/day#{padded_day}.txt", body)
    Mix.shell().info("Downloaded day #{day}'s input")
  end
end
