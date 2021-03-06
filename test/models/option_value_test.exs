defmodule Gcommerce.OptionValueTest do
  use Gcommerce.ModelCase
  alias Gcommerce.OptionValue

  @valid_attrs %{
    display_name: "some content",
    name: "some content",
    option_type_id: 1
  }
  @long_str String.duplicate("a", 201)
  @min_length [count: 3]
  @max_length [count: 200]

  test "changeset with valid attributes" do
    assert OptionValue.changeset(%OptionValue{}, @valid_attrs).valid?
  end

  test "changeset with invalid attributes" do
    refute OptionValue.changeset(%OptionValue{}, %{}).valid?
  end

  test "changeset with name length shorter than 3" do
    attrs = Map.merge(@valid_attrs, %{name: "a"})
    error = {:name, {"should be at least %{count} characters", @min_length}}

    assert error in errors_on(%OptionValue{}, attrs)
  end

  test "changeset with name length longer than 200" do
    attrs = Map.merge(@valid_attrs, %{name: @long_str})
    error = {:name, {"should be at most %{count} characters", @max_length}}

    assert error in errors_on(%OptionValue{}, attrs)
  end

  test "changeset with display_name length shorter than 3" do
    attrs = Map.merge(@valid_attrs, %{display_name: "a"})
    error = {:display_name, {"should be at least %{count} characters", @min_length}}

    assert error in errors_on(%OptionValue{}, attrs)
  end

  test "changeset with display_name length longer than 200" do
    attrs = Map.merge(@valid_attrs, %{display_name: @long_str})
    error = {:display_name, {"should be at most %{count} characters", @max_length}}

    assert error in errors_on(%OptionValue{}, attrs)
  end

  test "changeset with non existent option_type" do
    attrs = %{@valid_attrs | option_type_id: -1}
    {:error, changeset} = OptionValue.changeset(%OptionValue{}, attrs) |> Repo.insert

    refute changeset.valid?
    assert {:option_type_id, "does not exist"} in changeset.errors
  end

  test "changeset with name not unique on option_type" do
    {:ok, option_type} = Fixtures.option_type([]) |> Repo.insert
    option_value = Fixtures.option_value(option_type_id: option_type.id)
    option_value |> Repo.insert

    {:error, changeset} = option_value |> Repo.insert

    refute changeset.valid?
    assert {:name, "has already been taken"} in changeset.errors
  end
end
