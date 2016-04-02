defmodule NameAssignerTest do
  use ExUnit.Case

  test "get next available name" do
    nodes = [:"city_foo_blue@127.0.0.1", :"city_bar_yellow@127.0.0.1"]
    cities = ["foo", "bar", "baz"]

    assert "baz" == NameAssigner.find_unassigned_name(nodes, cities)
  end
end
