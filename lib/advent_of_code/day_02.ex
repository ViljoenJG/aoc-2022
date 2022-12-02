defmodule AdventOfCode.Day02 do
  alias AdventOfCode.Utils

  @options ["A", "B", "C"]
  @translations %{"X" => "A", "Y" => "B", "Z" => "C"}
  @planned_outcomes %{"X" => :loss, "Y" => :draw, "Z" => :win}

  def part1(input) do
    input
    |> parse_input()
    |> Enum.map(fn [x, y] -> [x, Map.get(@translations, y)] end)
    |> Enum.map(fn [a, b] ->
      opponent = Enum.find_index(@options, fn x -> x == a end)
      player = Enum.find_index(@options, fn x -> x == b end)
      score = player + 1

      cond do
        a == b -> score + 3
        player == rem(opponent + 1, 3) -> score + 6
        true -> score
      end
    end)
    |> Enum.sum()
  end

  def part2(input) do
    input
    |> parse_input()
    |> Enum.map(fn [a, b] ->
      opp = Enum.find_index(@options, fn x -> x == a end)

      case Map.get(@planned_outcomes, b) do
        :win -> rem(opp + 1, 3) + 1 + 6
        :loss -> rem(opp + 2, 3) + 1
        :draw -> opp + 1 + 3
      end
    end)
    |> Enum.sum()
  end

  defp parse_input(input) do
    input
    |> Utils.parse()
    |> Enum.map(&String.split/1)
  end
end
