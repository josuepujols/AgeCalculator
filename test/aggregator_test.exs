defmodule AggregatorTest do
  use ExUnit.Case
  doctest Aggregator

  test "convert_to_string/2 and return_list/1" do
    #data test
    tasks = [10, 9, 8, 7, 6]
    {:ok, pid}  = Aggregator.start_link()
    #act
    is_converted = Aggregator.convert_to_string(pid, tasks)
    list_converted = Enum.map(Aggregator.return_list(pid), fn item -> String.to_integer(item) end)
    #asserts
    assert is_converted == :ok
    assert list_converted !== tasks
  end
end
