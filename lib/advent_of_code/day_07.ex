defmodule AdventOfCode.Day07 do
  alias AdventOfCode.Utils

  def part1(input) do
    input
    |> parse()
    |> then(fn {_, dirs} ->
      dirs
      |> Map.values()
      |> Enum.reduce(0, fn
        x, acc when x <= 100_000 -> x + acc
        _, acc -> acc
      end)
    end)
  end

  def part2(input) do
    input
    |> parse()
    |> then(fn {_, dirs} ->
      size_req = Map.get(dirs, "/") - 40_000_000

      dirs
      |> Map.values()
      |> Enum.filter(&(&1 >= size_req))
      |> Enum.min()
    end)
  end

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
    |> Enum.reduce({[], %{}}, &navigate/2)
  end
end
