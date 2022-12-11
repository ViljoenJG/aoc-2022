defmodule AdventOfCode.Day11 do
  alias AdventOfCode.Utils

  def part1(input) do
    monkeys = parse(input)
    initial = Enum.map(monkeys, fn %{initial: initial} -> initial end)
    solve(20, &div(&1, 3), initial, monkeys)
  end

  def part2(input) do
    monkeys = parse(input)
    initial = Enum.map(monkeys, fn %{initial: initial} -> initial end)
    modulo = Enum.map(monkeys, & &1.divisor) |> Enum.product()
    solve(10_000, &rem(&1, modulo), initial, monkeys)
  end

  defp run(i, state, less_worry, monkeys) do
    monkey = Enum.at(monkeys, i)
    {_, worries} = Enum.at(state, i)

    worries
    |> Enum.reduce(
      state,
      fn worry, state ->
        new_worry = less_worry.(monkey.op.(worry))

        enqueue(
          state,
          Enum.at(monkey.throw, if(rem(new_worry, monkey.divisor) == 0, do: 0, else: 1)),
          new_worry
        )
      end
    )
    |> List.replace_at(i, {Enum.count(worries), []})
  end

  defp run_round(state, less_worry, monkeys),
    do: 0..7 |> Enum.reduce(state, &run(&1, &2, less_worry, monkeys))

  defp enqueue(state, n, x), do: state |> List.update_at(n, fn {c, ws} -> {c, ws ++ [x]} end)

  defp solve(rounds, less_worry, initial, monkeys) do
    initial
    |> Enum.map(&{0, &1})
    |> Stream.iterate(fn s -> run_round(s, less_worry, monkeys) end)
    |> Stream.drop(1)
    |> Enum.take(rounds)
    |> Enum.zip_reduce([], fn xs, acc -> [xs |> Enum.map(&elem(&1, 0)) |> Enum.sum() | acc] end)
    |> Enum.sort(:desc)
    |> Enum.take(2)
    |> Enum.product()
  end

  defp parse(input) do
    input
    |> Utils.parse("\n\n")
    |> Enum.map(fn x -> Utils.parse(x, "\n") |> Enum.map(&String.trim/1) end)
    |> Enum.map(fn x ->
      Enum.reduce(x, %{throw: [0, 0]}, fn
        "Operation: new = " <> op, acc ->
          Map.put(acc, :op, get_operation(op))

        "Test: divisible by " <> d, acc ->
          Map.put(acc, :divisor, String.to_integer(d))

        "If true: throw to monkey " <> x, acc ->
          Map.update!(acc, :throw, fn [_t, f] -> [String.to_integer(x), f] end)

        "If false: throw to monkey " <> x, acc ->
          Map.update!(acc, :throw, fn [t, _f] -> [t, String.to_integer(x)] end)

        "Starting items: " <> items, acc ->
          Map.put(acc, :initial, Utils.parse_int(items, ", "))

        _, acc ->
          acc
      end)
    end)
  end

  defp get_operation(op) when is_binary(op), do: get_operation(String.split(op, " "))
  defp get_operation(["old", "+", "old"]), do: &(&1 + &1)
  defp get_operation(["old", "*", "old"]), do: &(&1 * &1)
  defp get_operation(["old", "+", b]), do: &(&1 + String.to_integer(b))
  defp get_operation(["old", "*", b]), do: &(&1 * String.to_integer(b))
end
