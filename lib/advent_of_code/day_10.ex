defmodule AdventOfCode.Day10 do
  alias AdventOfCode.Utils

  def part1(input) do
    parse(input)
    |> instructions()
    |> Enum.drop(19)
    |> Enum.take_every(40)
    |> Enum.map(fn {x, y} -> x * y end)
    |> Enum.sum()
  end

  def part2(input) do
    parse(input)
    |> instructions()
    |> Enum.drop(-1)
    |> Enum.reduce("", fn {x, cycle}, crt ->
      crt_pos = rem(cycle - 1, 40)

      if crt_pos - 1 <= x and x <= crt_pos + 1 do
        crt <> "█"
      else
        crt <> " "
      end
    end)
    |> String.graphemes()
    |> Enum.chunk_every(40)
    |> Enum.join("\n")
    |> then(&(&1 <> "\n"))
  end

  defp instructions(instructions) do
    instructions
    |> Enum.flat_map(&with_cycles/1)
    |> Enum.scan(1, fn
      :noop, x -> x
      {:addx, n}, x -> n + x
    end)
    |> then(&[1 | &1])
    |> Enum.with_index(1)
  end

  defp with_cycles(:noop), do: [:noop]
  defp with_cycles({:addx, n}), do: [:noop, {:addx, n}]

  defp parse(input) do
    input
    |> Utils.parse()
    |> Enum.map(fn line ->
      case Utils.parse(line, " ") do
        ["noop"] -> :noop
        ["addx", val] -> {:addx, String.to_integer(val)}
      end
    end)
  end
end
