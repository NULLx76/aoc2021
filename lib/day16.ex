defmodule Aoc2021.Day16 do
  @moduledoc false

  @sum 0
  @product 1
  @min 2
  @max 3
  @literal 4
  @gt 5
  @lt 6
  @eq 7

  defp parse(file) do
    input = File.read!(file) |> String.trim()
    int = String.to_integer(input, 16)

    size = byte_size(input)
    <<int::integer-size(size)-unit(4)>>
  end

  defp decode_literal(bits, acc \\ 0) do
    case bits do
      <<1::1, n::size(4), rest::bits>> -> decode_literal(rest, acc * 16 + n)
      <<0::1, n::size(4), rest::bits>> -> {acc * 16 + n, rest}
    end
  end

  def decode_n_packets(bits, 0, acc), do: {Enum.reverse(acc), bits}

  def decode_n_packets(bits, num, acc) do
    {packet, rest} = decode_packet(bits)
    decode_n_packets(rest, num - 1, [packet | acc])
  end

  defp decode_packets(bits, acc) do
    case decode_packet(bits) do
      {:none, rest} -> {Enum.reverse(acc), rest}
      {packet, rest} -> decode_packets(rest, [packet | acc])
    end
  end

  def decode_operator(bits) do
    case bits do
      <<0::1, len::size(15), rest::bits>> ->
        <<packets::bits-size(len), rest::bits>> = rest
        {packets, <<>>} = decode_packets(packets, [])
        {packets, rest}

      <<1::1, len::size(11), rest::bits>> ->
        decode_n_packets(rest, len, [])
    end
  end

  defp decode_packet(bits) do
    case bits do
      <<ver::size(3), id::size(3), rest::bits>> ->
        case id do
          @literal ->
            {literal, rest} = decode_literal(rest)
            {{ver, @literal, literal}, rest}

          _ ->
            {packets, rest} = decode_operator(rest)
            {{ver, id, packets}, rest}
        end

      _ ->
        {:none, bits}
    end
  end

  defp version_sum({version, @literal, _}, sum), do: sum + version
  defp version_sum({version, _, packets}, sum), do: Enum.reduce(packets, sum + version, &version_sum/2)

  def part1(file \\ "./inputs/day16.txt") do
    parse(file)
    |> decode_packet()
    |> elem(0)
    |> version_sum(0)
  end

  defp eval_packet({_, @literal, value}), do: value

  defp eval_packet({_, id, arguments}) do
    arguments = Enum.map(arguments, &eval_packet/1)

    case id do
      @sum ->
        Enum.sum(arguments)

      @product ->
        Enum.reduce(arguments, 1, &*/2)

      @min ->
        Enum.min(arguments)

      @max ->
        Enum.max(arguments)

      @gt ->
        [first, second] = arguments
        if first > second, do: 1, else: 0

      @lt ->
        [first, second] = arguments
        if first < second, do: 1, else: 0

      @eq ->
        [first, second] = arguments
        if first == second, do: 1, else: 0
    end
  end

  def part2(file \\ "./inputs/day16.txt") do
    parse(file)
    |> decode_packet()
    |> elem(0)
    |> eval_packet()
  end
end
