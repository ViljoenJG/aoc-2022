defmodule AdventOfCode.Day07 do
  alias AdventOfCode.Utils

  def part1(input) do
    input
    |> parse()
    |> navigate_lines()
    |> solve1()
  end

  def part2(input) do
    input
    |> parse()
    |> navigate_lines()
    |> then(fn {_path, dirs} ->
      size = Map.get(dirs, "/") - 40_000_000
      {size, dirs}
    end)
    |> solve2()
  end

  defp solve1({_path, dirs}) do
    dirs
    |> Map.values()
    |> Enum.filter(&(&1 <= 100_000))
    |> Enum.sum()
  end

  defp solve2({size_req, dirs}) do
    dirs
    |> Map.values()
    |> Enum.filter(&(&1 >= size_req))
    |> Enum.min()
  end

  defp navigate_lines(lines), do: Enum.reduce(lines, {[], %{}}, &navigate/2)

  defp navigate(["$", "cd", ".."], {[_ | path], dirs}), do: {path, dirs}
  defp navigate(["$", "cd", "/"], {_, dirs}), do: {["/"], dirs}
  defp navigate(["$", "ls"], data), do: data
  defp navigate(["dir", _], data), do: data
  defp navigate(["$", "cd", dir], {path, dirs}), do: {[dir | path], dirs}

  defp navigate([s_size, _filename], {path, dirs}) do
    {size, _} = Integer.parse(s_size)
    {path, update_recursively(path, dirs, size)}
  end

  defp update_recursively([], dirs, _size), do: dirs

  defp update_recursively([_cur | rest] = paths, dirs, size) do
    cd = Enum.join(paths, ".")
    update_recursively(rest, Map.update(dirs, cd, size, &(&1 + size)), size)
  end

  defp parse(input) do
    input
    |> Utils.parse()
    |> Enum.map(&Utils.parse(&1, " "))
  end
end
