defmodule Weatherise.CLI do

  @moduledoc """
  Handle the command line parsing and dispatch to
  the various functions that end up generating the
  information about the weather near the airport passed.
  """
  def main(argv) do
    argv
    |> parse_args
    |> process
  end

  @doc """
  `argv` can be -h or --help, which returns :help.

  Otherwise it is USA city airport identifier upcased.

  Return a string `AIRPORT_ID`, or `:help` if help was given
  """
  def parse_args(argv) do
    parse = OptionParser.parse(argv, switches: [ help: :boolean ],
                                                 aliases: [h: :help])
    case parse do
      { [ help: true ], _, _  } -> :help
      { _, [ airport_id ] , _ } -> String.upcase(airport_id)
      _                         -> :help
    end
  end

  def process(:help) do
    IO.puts """
    usage: weatherise <usa_city_airport_id>
    """
    System.halt(0)
  end

  def process(airport_id) do
    airport_id
    |> Weatherise.WeatherInfo.fetch
    |> print_response
  end

  def print_response({ :error, message }) do
    IO.puts message
    System.halt(2)
  end

  def print_response({ :ok, response }) do
    Weatherise.OutputFormatter.format(response)
  end
end
