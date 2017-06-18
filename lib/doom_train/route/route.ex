defmodule DoomTrain.Route do
  @moduledoc """
  The boundary for the Route system.
  """

  import Ecto.Query, warn: false
  alias DoomTrain.Repo

  alias DoomTrain.Route.Path

  @doc """
  Returns the list of paths.

  ## Examples

      iex> list_paths()
      [%Path{}, ...]

  """
  def list_paths do
    Repo.all(Path)
  end

  @doc """
  Gets a single path.

  Raises `Ecto.NoResultsError` if the Path does not exist.

  ## Examples

      iex> get_path!(123)
      %Path{}

      iex> get_path!(456)
      ** (Ecto.NoResultsError)

  """
  def get_path!(id), do: Repo.get!(Path, id)

  @doc """
  Creates a path.

  ## Examples

      iex> create_path(%{field: value})
      {:ok, %Path{}}

      iex> create_path(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_path(attrs \\ %{}) do
    %Path{}
    |> Path.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a path.

  ## Examples

      iex> update_path(path, %{field: new_value})
      {:ok, %Path{}}

      iex> update_path(path, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_path(%Path{} = path, attrs) do
    path
    |> Path.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Path.

  ## Examples

      iex> delete_path(path)
      {:ok, %Path{}}

      iex> delete_path(path)
      {:error, %Ecto.Changeset{}}

  """
  def delete_path(%Path{} = path) do
    Repo.delete(path)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking path changes.

  ## Examples

      iex> change_path(path)
      %Ecto.Changeset{source: %Path{}}

  """
  def change_path(%Path{} = path) do
    Path.changeset(path, %{})
  end
end
