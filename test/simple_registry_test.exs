defmodule SimpleRegistryTest do
  use ExUnit.Case
  doctest SimpleRegistry

  test "can register a process" do
    {:ok, _pid} = SimpleRegistry.start_link()

    assert :ok == SimpleRegistry.register("some_name")
  end

  test "cannot register a second process with the same name" do
    {:ok, _pid} = SimpleRegistry.start_link()

    SimpleRegistry.register("some_name")
    assert :error == SimpleRegistry.register("some_name")
  end

  test "looking up a process by name returns a pid" do
    {:ok, _pid} = SimpleRegistry.start_link()

    SimpleRegistry.register("some_name")

    assert SimpleRegistry.whereis("some_name") == self()
  end

  test "looking up a process that does not exist returns nil" do
    {:ok, _pid} = SimpleRegistry.start_link()

    assert SimpleRegistry.whereis("blah") == nil
  end
end
