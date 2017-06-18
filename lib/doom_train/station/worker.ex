defmodule DoomTrain.Station.Worker do
  use GenServer

  # Client API

  def start_link(name) do
    GenServer.start_link(__MODULE__, :ok, name: name)
  end

  # Server Callbacks

  def init(:ok) do
    {:ok, %{}}
  end
end
