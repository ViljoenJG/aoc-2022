defmodule AdventOfCode.Day08 do
  alias AdventOfCode.Utils

  def part1(input),
    do: input |> Utils.parse_grid_int() |> search()

  def part2(input),
    do: input |> Utils.parse_grid_int() |> scenic_score()

  defp count_edges(grid), do: (grid |> Enum.at(0) |> length()) * 4 - 4

  defp up(grid, row, col), do: grid |> Enum.slice(0..(row - 2)) |> Enum.map(&Enum.at(&1, col - 1))

  defp down(grid, row, col),
    do: grid |> Enum.slice(row..(length(grid) - 1)) |> Enum.map(&Enum.at(&1, col - 1))

  defp left(grid, row, col), do: grid |> Enum.at(row - 1) |> Enum.slice(0..(col - 2))
  defp right(grid, row, col), do: grid |> Enum.at(row - 1) |> Enum.slice(col..(length(grid) - 1))
  defp cur(grid, row, col), do: grid |> Enum.at(row - 1) |> Enum.at(col - 1)

  defp all(grid, row, col),
    do: [
      up(grid, row, col) |> Enum.reverse(),
      down(grid, row, col),
      left(grid, row, col) |> Enum.reverse(),
      right(grid, row, col)
    ]

  defp search(grid), do: search(grid, 2, 2, count_edges(grid))
  defp search(grid, row, _, val) when row == length(grid), do: val

  defp search(grid, row, col, val) when col == length(grid) - 1,
    do: search(grid, row + 1, 2, val + visible?(grid, row, col))

  defp search(grid, row, col, val), do: search(grid, row, col + 1, val + visible?(grid, row, col))

  defp scenic_score(grid), do: scenic_score(grid, 2, 2, 0)
  defp scenic_score(grid, row, _, score) when row == length(grid), do: score

  defp scenic_score(grid, row, col, score) when col == length(grid) - 1,
    do: scenic_score(grid, row + 1, 2, max(total(grid, row, col), score))

  defp scenic_score(grid, row, col, score),
    do: scenic_score(grid, row, col + 1, max(total(grid, row, col), score))

  defp total(grid, row, col),
    do:
      all(grid, row, col) |> Enum.map(&score(&1, cur(grid, row, col))) |> Enum.reduce(&(&1 * &2))

  defp score(row, cur) do
    visible = Enum.take_while(row, &(&1 < cur))
    if length(visible) == length(row), do: length(visible), else: length(visible) + 1
  end

  defp visible?(grid, row, col) do
    grid
    |> all(row, col)
    |> Enum.any?(fn x -> x |> Enum.all?(&(&1 < cur(grid, row, col))) end)
    |> then(fn
      true -> 1
      false -> 0
    end)
  end
end
