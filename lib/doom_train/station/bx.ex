defmodule DoomTrain.Station.Bx do
  use GenServer

  alias DoomTrain.Bx

  # Client API

  def start_link(name) do
    GenServer.start_link(__MODULE__, :ok, name: name)
  end

  # Server Callbacks

  def init(:ok) do
    schedule_currency_pairing()
    {:ok, %{}}
  end

  def handle_info(:currency_pairing, state) do
    Bx.currency_pairings() |> IO.inspect

    schedule_currency_pairing()

    {:noreply, state}
  end

  defp schedule_currency_pairing do
    Process.send_after(self(), :currency_pairing, 60 * 1000)
  end
end
