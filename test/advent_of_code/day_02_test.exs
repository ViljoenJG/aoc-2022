defmodule AdventOfCode.Day02Test do
  use ExUnit.Case

  import AdventOfCode.Day02

  @input """
  A Y
  B X
  C Z
  """

  # @tag :skip
  test "part1" do
    result = part1(@input)
    assert result == 15
  end

  # @tag :skip
  test "part2" do
    result = part2(@input)
    assert result == 12
  end
end
