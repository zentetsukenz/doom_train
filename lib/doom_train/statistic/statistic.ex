defmodule DoomTrain.Statistic do
  @spec sma([float()], integer()) :: [float()]
  def sma(_, period) when period < 2, do: :error
  def sma(list, period) do
    if Enum.count(list) >= period do
      initial_array = List.duplicate(nil, period - 1)

      do_sma(initial_array, list, period)
    else
      []
    end
  end

  defp do_sma(sma_list, list, period) when length(list) >= period do
    sum_block =
      list
      |> Enum.take(period)
      |> Enum.reduce(&+/2)

    average_block = sum_block / period

    [_ | the_rest] = list

    do_sma([average_block | sma_list], the_rest, period)
  end
  defp do_sma(sma_list, list, period) when length(list) < period do
    Enum.reverse(sma_list)
  end
end
