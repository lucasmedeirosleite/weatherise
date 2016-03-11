defmodule Weatherise.OutputFormatter do

  def format(data) do
    IO.puts ""
    for key <- Map.keys(data), do: print_line(data, key)
  end

  defp print_line(data, key) do
    key
    |> to_string
    |> String.capitalize
    |> do_print(data, key)
  end

  defp do_print(title, data, key) do
    IO.puts "#{title}: #{data[key]}"
  end
end
