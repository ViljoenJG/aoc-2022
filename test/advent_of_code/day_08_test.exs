defmodule AdventOfCode.Day08Test do
  use ExUnit.Case

  import AdventOfCode.Day08

  @input """
  30373
  25512
  65332
  33549
  35390
  """

  test "part1" do
    assert part1(@input) == 21
  end

  test "part2" do
    assert part2(@input) == 8
  end
end
