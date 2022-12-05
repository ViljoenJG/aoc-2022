defmodule AdventOfCode.Day05 do
  def part1(input) do
    input
    |> parse()
    |> rearrange(&crate_mover_9000/2)
    |> Enum.map(&List.first/1)
    |> Enum.join("")
  end

  def part2(input) do
    input
    |> parse()
    |> rearrange(&crate_mover_9001/2)
    |> Enum.map(&List.first/1)
    |> Enum.join("")
  end

  defp rearrange([stacks, instructions], transfer_fn) do
    Enum.reduce(instructions, stacks, &transfer_fn.(&1, &2))
  end

  defp crate_mover_9000([0, _, _], stacks), do: stacks

  defp crate_mover_9000([amount, from, to], stacks) do
    [x | from_new] = Enum.at(stacks, from - 1)
    to_new = [x | Enum.at(stacks, to - 1)]

    crate_mover_9000(
      [amount - 1, from, to],
      stacks |> List.replace_at(from - 1, from_new) |> List.replace_at(to - 1, to_new)
    )
  end

  defp crate_mover_9001([amount, from, to], stacks) do
    xs = Enum.at(stacks, from - 1) |> Enum.take(amount)
    from_new = Enum.at(stacks, from - 1) |> Enum.drop(amount)
    to_new = xs ++ Enum.at(stacks, to - 1)
    stacks |> List.replace_at(from - 1, from_new) |> List.replace_at(to - 1, to_new)
  end

  defp parse(input) do
    [stacks, instructions] =
      input
      |> String.split("\n\n", trim: true)
      |> Enum.map(&String.split(&1, "\n", trim: true))

    [parse_stacks(stacks), parse_instructions(instructions)]
  end

  defp parse_stacks(stacks) do
    stacks
    |> Enum.map(fn s ->
      xs = String.split(s, "", trim: true)
      Enum.map([1, 5, 9, 13, 17, 21, 25, 29, 33], &Enum.at(xs, &1))
    end)
    |> Enum.drop(-1)
    |> Enum.zip_with(& &1)
    |> Enum.map(fn l -> Enum.drop_while(l, &(&1 == " " or &1 == nil)) end)
  end

  defp parse_instructions(instructions) do
    instructions
    |> Enum.map(fn s ->
      xs = String.split(s, " ", trim: true)
      Enum.map([1, 3, 5], &(Enum.at(xs, &1) |> String.to_integer()))
    end)
  end
end
