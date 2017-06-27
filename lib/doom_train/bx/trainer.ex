defmodule DoomTrain.Bx.Trainer do
  alias DoomTrain.Statistic
  alias DoomTrain.Bx.Agent
  alias DoomTrain.Route.Path
  alias DoomTrain.Bx.Discretizer

  @spec train(Agent.state, [Path]) :: Agent.state
  def train(state, training_data) do
    {training_part, _testing_part} = setup_training_data(training_data)

    adjusted_close_list = Enum.map(training_part, fn(path) -> path.close end)
    prepared_data = %{
      adjusted_close: adjusted_close_list,
      sma: Statistic.sma(adjusted_close_list, 7),
    }

    do_train(state, prepared_data)
  end

  defp do_train(state, %{adjusted_close: adjusted_close_list, sma: sma}) do
    close_sma_ratios =
      adjusted_close_list
      |> Enum.zip(sma)
      |> Enum.reduce([], &adj_sma_ratio/2)
      |> Enum.reverse()

    discretizer_params = %{step: 10, data: close_sma_ratios}

    {:ok, close_sma_ratio_discretizer} = Discretizer.start_link(discretizer_params)

    start_training(state, close_sma_ratios, adjusted_close_list, close_sma_ratio_discretizer)
  end

  defp start_training(state, close_sma_ratios, adjusted_close_list, discretizer) do
    training(state, close_sma_ratios, adjusted_close_list, discretizer)
  end

  defp training(state, [close_sma_ratio | close_sma_ratios], adjusted_close_list, discretizer) do
    [today_price | the_rest_price] = adjusted_close_list
    q_table = state.q_table
    current_state = {Discretizer.discretize(discretizer, close_sma_ratio)}
    new_q_table = Map.put(q_table, current_state, {0, 0, 0})
    new_state = Map.put(state, :q_table, new_q_table)

    training(new_state, close_sma_ratios, the_rest_price, discretizer)
  end
  defp training(state, [], _) do
    state
  end

  defp setup_training_data(training_data) do
    record_count = Enum.count(training_data)
    # Split it with 80/20 ratio
    {training_part, testing_part} =
      Enum.split(training_data, round(record_count * 0.8))
  end

  defp adj_sma_ratio({adj_close, sma}, arr) when sma != nil do
    ratio = adj_close / sma
    [ratio | arr]
  end
  defp adj_sma_ratio({adj_close, nil}, arr) do
    arr
  end
end
