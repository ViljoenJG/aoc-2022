defmodule AdventOfCode.Day06 do
  def part1(input), do: solve(input, 4)

  def part2(input), do: solve(input, 14)

  defp solve(data_stream, max_num) do
    data_stream
    |> split()
    |> Enum.with_index()
    |> Enum.find(fn {_, i} ->
      parts = split(String.slice(data_stream, i, max_num))
      length(Enum.uniq(parts)) == max_num
    end)
    |> then(fn {_, i} -> i + max_num end)
  end

  defp split(input), do: String.split(input, "", trim: true)
end
