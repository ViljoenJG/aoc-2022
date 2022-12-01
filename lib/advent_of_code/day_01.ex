defmodule AdventOfCode.Day01 do
  alias AdventOfCode.Utils

  def part1(input) do
    input
    |> elves_inventories()
    |> calories_per_elf()
    |> get_max()
  end

  def part2(input) do
    input
    |> elves_inventories()
    |> calories_per_elf()
    |> get_max(3)
  end

  defp elves_inventories(input) do
    input
    |> String.split("\n\n", trim: true)
    |> Enum.map(&Utils.parse_int/1)
  end

  defp calories_per_elf(inventory) do
    inventory
    |> Enum.map(&Enum.sum/1)
  end

  defp get_max(totals, n_elves) do
    totals
    |> Enum.sort(&(&1 >= &2))
    |> Enum.take(n_elves)
    |> Enum.sum()
  end

  defp get_max(totals) do
    Enum.max(totals)
  end
end
