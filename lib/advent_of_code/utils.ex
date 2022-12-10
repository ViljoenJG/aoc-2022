defmodule AdventOfCode.Utils do
  def parse(input) do
    input
    |> String.split("\n", trim: true)
  end

  def parse(input, sep, options \\ [trim: true]) do
    input
    |> String.split(sep, options)
  end

  # def parse_grid(input) do
  #   input
  #   |> parse("\n")
  #   |> Enum.map(&parse(&1, ""))
  # end

  def parse_grid(input, sep1 \\ "\n", sep2 \\ "", options \\ [trim: true]) do
    input
    |> parse(sep1, options)
    |> Enum.map(&parse(&1, sep2, options))
  end

  def parse_grid_int(input) do
    input
    |> parse()
    |> Enum.map(&parse_int(&1, ""))
  end

  def parse_int(input) do
    input
    |> parse()
    |> Enum.map(&String.to_integer/1)
  end

  def parse_int(input, sep, options \\ [trim: true]) do
    input
    |> parse(sep, options)
    |> Enum.map(&String.to_integer/1)
  end
end
