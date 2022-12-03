defmodule AdventOfCode.Day03 do
  alias AdventOfCode.Utils

  def part1(input) do
    input
    |> parse()
    |> Stream.map(&splitter/1)
    |> Stream.map(&find_dup/1)
    |> Stream.map(&get_value/1)
    |> Enum.sum()
  end

  def part2(input) do
    input
    |> parse()
    |> Stream.chunk_every(3)
    |> Stream.map(&find_dup/1)
    |> Stream.map(&get_value/1)
    |> Enum.sum()
  end

  defp splitter(line) do
    split = div(String.length(line), 2)

    line
    |> String.split_at(split)
    |> Tuple.to_list()
  end

  defp parse(input) do
    input
    |> Utils.parse()
  end

  defp find_dup([a, b]) do
    to_map_set(a)
    |> MapSet.intersection(to_map_set(b))
    |> MapSet.to_list()
    |> Enum.join()
  end

  defp find_dup([a, b | rest]) do
    find_dup([find_dup([a, b]) | rest])
  end

  defp get_value(char) do
    case String.upcase(char) == char do
      true -> :binary.at(char, 0) - 38
      false -> :binary.at(char, 0) - 96
    end
  end

  defp to_map_set(str),
    do: MapSet.new(String.split(str, "", trim: true))
end
