defmodule CLITest do
  use ExUnit.Case
  doctest Weatherise

  import Weatherise.CLI, only: [ parse_args: 1 ]

  test ":help returned by option parsing with -h and --help options" do
    assert parse_args(["-h",     "anything"]) == :help
    assert parse_args(["--help", "anything"]) == :help
  end

  test "return the given value  upcased" do
    assert parse_args(["nybx"]) == "NYBX"
    assert parse_args(["nYBx"]) == "NYBX"
    assert parse_args(["NYBX"]) == "NYBX"
  end
end
