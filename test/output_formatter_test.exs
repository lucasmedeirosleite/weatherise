defmodule OutputFormatterTest do
  use ExUnit.Case
  import ExUnit.CaptureIO

  alias Weatherise.OutputFormatter, as: OF

  import Weatherise.OutputFormatter, only: [ format: 1 ]

  test "output is correct" do
    result = capture_io fn ->
      OF.format(mock_data)
    end

    assert result == """

    Key1: Value 1
    Key2: Value 2
    Key3: Value 3
    Key4: Value 4
    """
  end

  defp mock_data do
    %{
        key1: "Value 1",
        key2: "Value 2",
        key3: "Value 3",
        key4: "Value 4",
     }
  end

end
