defmodule DoomTrain.RouteTest do
  use DoomTrain.DataCase

  alias DoomTrain.Route

  describe "paths" do
    alias DoomTrain.Route.Path

    @valid_attrs %{
      average:       "120.5",
      close:         "120.5",
      destination:   "ETH",
      high:          "120.5",
      low:           "120.5",
      open:          "120.5",
      source:        "THB",
      station:       "BX",
      timestamp:     %DateTime{
        calendar:    Calendar.ISO,
        day:         17,
        hour:        14,
        microsecond: {0, 6},
        minute:      0,
        month:       4,
        second:      0,
        std_offset:  0,
        time_zone:   "Etc/UTC",
        utc_offset:  0,
        year:        2010,
        zone_abbr:   "UTC"
      },
      volume:        "120.5"
    }

    @update_attrs %{
      average:       "456.7",
      close:         "456.7",
      destination:   "BTC",
      high:          "456.7",
      low:           "456.7",
      open:          "456.7",
      source:        "THB",
      station:       "BX",
      timestamp:     %DateTime{
        calendar:    Calendar.ISO,
        day:         18,
        hour:        15,
        microsecond: {0, 6},
        minute:      1,
        month:       5,
        second:      1,
        std_offset:  0,
        time_zone:   "Etc/UTC",
        utc_offset:  0,
        year:        2011,
        zone_abbr:   "UTC"
      },
      volume:        "456.7"
    }

    @invalid_attrs %{
      average:     nil,
      close:       nil,
      destination: nil,
      high:        nil,
      low:         nil,
      open:        nil,
      source:      nil,
      station:     nil,
      timestamp:   nil,
      volume:      nil
    }

    def path_fixture(attrs \\ %{}) do
      {:ok, path} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Route.create_path()

      path
    end

    test "list_paths/0 returns all paths" do
      path = path_fixture()
      assert Route.list_paths() == [path]
    end

    test "get_path!/1 returns the path with given id" do
      path = path_fixture()
      assert Route.get_path!(path.id) == path
    end

    test "create_path/1 with valid data creates a path" do
      assert {:ok, %Path{} = path} = Route.create_path(@valid_attrs)
      assert path.average == 120.5
      assert path.close == 120.5
      assert path.high == 120.5
      assert path.low == 120.5
      assert path.open == 120.5
      assert path.destination == "ETH"
      assert path.source == "THB"
      assert path.station == "BX"
      assert path.timestamp == %DateTime{calendar: Calendar.ISO, day: 17, hour: 14, microsecond: {0, 6}, minute: 0, month: 4, second: 0, std_offset: 0, time_zone: "Etc/UTC", utc_offset: 0, year: 2010, zone_abbr: "UTC"}
      assert path.volume == 120.5
    end

    test "create_path/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Route.create_path(@invalid_attrs)
    end

    test "update_path/2 with valid data updates the path" do
      path = path_fixture()
      assert {:ok, path} = Route.update_path(path, @update_attrs)
      assert %Path{} = path
      assert path.average == 456.7
      assert path.close == 456.7
      assert path.destination == "BTC"
      assert path.high == 456.7
      assert path.low == 456.7
      assert path.open == 456.7
      assert path.source == "THB"
      assert path.station == "BX"
      assert path.timestamp == %DateTime{calendar: Calendar.ISO, day: 18, hour: 15, microsecond: {0, 6}, minute: 1, month: 5, second: 1, std_offset: 0, time_zone: "Etc/UTC", utc_offset: 0, year: 2011, zone_abbr: "UTC"}
      assert path.volume == 456.7
    end

    test "update_path/2 with invalid data returns error changeset" do
      path = path_fixture()
      assert {:error, %Ecto.Changeset{}} = Route.update_path(path, @invalid_attrs)
      assert path == Route.get_path!(path.id)
    end

    test "delete_path/1 deletes the path" do
      path = path_fixture()
      assert {:ok, %Path{}} = Route.delete_path(path)
      assert_raise Ecto.NoResultsError, fn -> Route.get_path!(path.id) end
    end

    test "change_path/1 returns a path changeset" do
      path = path_fixture()
      assert %Ecto.Changeset{} = Route.change_path(path)
    end
  end
end
