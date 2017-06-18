defmodule DoomTrain.Repo.Migrations.CreateDoomTrain.Route.Path do
  use Ecto.Migration

  def change do
    create table(:route_paths) do
      add :station, :string
      add :source, :string
      add :destination, :string
      add :timestamp, :utc_datetime
      add :average, :float
      add :close, :float
      add :high, :float
      add :low, :float
      add :open, :float
      add :volume, :float

      timestamps()
    end

  end
end
