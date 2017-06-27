defmodule DoomTrain.Bx.Agent do
  use GenServer

  alias DoomTrain.Bx.Hyperparameter
  alias DoomTrain.Route.Path

  @type q_table :: Map.t
  @type state :: %{
    hyperparameter: Hyperparameter.t,
    q_table:        __MODULE__.q_table,
  }
  @type training_data :: [Path]

  # Client

  @spec start_link(Hyperparameter.t, Keyword.t) :: GenServer.on_start()
  def start_link(hyperparameter, options \\ []) do
    GenServer.start_link(__MODULE__, hyperparameter, options)
  end

  @spec train(pid, [Path]) :: :ok
  def train(pid, training_data) do
    GenServer.cast(pid, {:train, training_data})
  end

  # Server

  @spec init(Hyperparameter.t) :: {:ok, __MODULE__.state}
  def init(hyperparameter) do
    state = Map.put(hyperparameter, :q_table, %{})
    {:ok, state}
  end

  @spec handle_cast({:train, __MODULE__.training_data}, __MODULE__.state) :: {:noreply, __MODULE__.state}
  def handle_cast({:train, training_data}, state) do
    new_state = DoomTrain.Bx.Trainer.train(state, training_data)
    {:noreply, new_state}
  end
end
