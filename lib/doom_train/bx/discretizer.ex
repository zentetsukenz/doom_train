defmodule DoomTrain.Bx.Discretizer do
  use GenServer

  @type discretizing_parameters :: %{
    step: integer(),
    data: list(float()),
  }

  # Client

  @spec start_link(discretizing_parameters, Keyword.t) :: GenServer.on_start()
  def start_link(discretizing_parameters, options \\ []) do
    GenServer.start_link(__MODULE__, discretizing_parameters, options)
  end

  @spec threshold(pid()) :: term
  def threshold(pid) do
    GenServer.call(pid, {:threshold})
  end

  @spec discretize(pid(), float()) :: term
  def discretize(pid, value) do
    GenServer.call(pid, {:discretize, value})
  end

  @spec update_data(pid(), list(float())) :: :ok
  def update_data(pid, data) do
    GenServer.cast(pid, {:update_data, data})
  end

  # Server

  @spec init(discretizing_parameters) :: {:ok, __MODULE__.discretizing_parameters}
  def init(%{data: data, step: step}) do
    threshold = thresholding(data, step)
    {:ok, %{data: data, step: step, threshold: threshold}}
  end

  def handle_call({:threshold}, _from, state) do
    {:reply, Map.get(state, :threshold), state}
  end

  def handle_call({:discretize, value}, _from, state) do
    threshold = Map.get(state, :threshold)
    index = case Enum.find_index(threshold, fn(t) -> value < t end) do
      some_number when is_integer(some_number) -> some_number
      nil -> length(threshold) - 1
    end
    {:reply, index, state}
  end

  def handle_cast({:update_data, new_data}, %{step: step} = state) do
    new_threshold = thresholding(new_data, step)
    new_state = %{state | data: new_data, threshold: new_threshold}

    {:noreply, new_state}
  end

  defp thresholding(data, step) do
    data_length = length(data)
    step_size = (data_length / step) |> round
    sorted_data = Enum.sort(data)
    for i <- 0..(step - 1) do
      data_index = ((i + 1) * step_size) - 1
      if data_index < data_length do
        Enum.at(sorted_data, data_index)
      else
        List.last(sorted_data)
      end
    end
  end
end
