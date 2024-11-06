defmodule BenchWebTest do
  use ExUnit.Case
  doctest BenchWeb

  test "greets the world" do
    assert BenchWeb.hello() == :world
  end
end
