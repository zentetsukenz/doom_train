defmodule DoomTrain.Route.Path do
  use Ecto.Schema
  import Ecto.Changeset
  alias DoomTrain.Route.Path


  schema "route_paths" do
    field :station,     :string
    field :timestamp,   :utc_datetime
    field :destination, :string
    field :source,      :string

    field :average,     :float
    field :close,       :float
    field :high,        :float
    field :low,         :float
    field :open,        :float
    field :volume,      :float

    timestamps()
  end

  @doc false
  def changeset(%Path{} = path, attrs) do
    path
    |> cast(attrs, [:station, :source, :destination, :timestamp, :average, :close, :high, :low, :open, :volume])
    |> validate_required([:station, :source, :destination, :timestamp, :average, :close, :high, :low, :open, :volume])
  end
end
