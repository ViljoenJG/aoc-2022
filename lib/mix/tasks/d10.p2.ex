defmodule Mix.Tasks.D10.P2 do
  use Mix.Task

  import AdventOfCode.Day10

  @shortdoc "Day 10 Part 2"
  def run(args) do
    input = AdventOfCode.Input.get!(10, 2022)

    if Enum.member?(args, "-b"),
      do: Benchee.run(%{part_2: fn -> input |> part2() end}),
      else:
        input
        |> part2()
        |> then(fn res ->
          for line <- String.split(res, "\n") do
            IO.puts(line)
          end
        end)
  end
end
