defmodule AdventOfCode.Day04 do
  alias AdventOfCode.Utils

  def part1(input) do
    input
    |> parse()
    |> Enum.map(&complete_overlap/1)
    |> Enum.sum()
  end

  def part2(input) do
    input
    |> parse()
    |> Enum.map(&partial_overlap/1)
    |> Enum.sum()
  end

  def complete_overlap([[start_a, end_a], [start_b, end_b]]) do
    cond do
      start_a >= start_b and end_a <= end_b -> 1
      start_b >= start_a and end_b <= end_a -> 1
      true -> 0
    end
  end

  def partial_overlap([[start_a, end_a], [start_b, end_b]]) do
    cond do
      start_a >= start_b and start_a <= end_b -> 1
      end_a >= start_b and end_a <= end_b -> 1
      start_b >= start_a and start_b <= end_a -> 1
      end_b >= start_a and end_b <= end_a -> 1
      true -> 0
    end
  end

  def parse(input) do
    input
    |> Utils.parse()
    |> Enum.map(&parse_line/1)
  end

  defp parse_line(line) do
    line
    |> Utils.parse(",")
    |> Enum.map(&Utils.parse_int(&1, "-"))
  end
end
