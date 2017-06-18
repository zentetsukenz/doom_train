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
    {:ok, %{currency_pairs: nil}}
  end

  def handle_info(:currency_pairing, state) do
    currency_pairs = Bx.currency_pairings().body

    schedule_currency_pairing()
    {:noreply, Map.put(state, :currency_pairs, currency_pairs)}
  end

  # Scheduling

  defp schedule_currency_pairing do
    #  Schedule it to run again next 24 hrs
    #  TODO: Next running time must be calibrate to run at a specific time
    #  instead of let it drifts away everyday.
    Process.send_after(self(), :currency_pairing, 24 * 60 * 60 * 1000)
  end
end
