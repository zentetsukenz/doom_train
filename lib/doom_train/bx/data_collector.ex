defmodule DoomTrain.Bx.DataCollector do
  alias DoomTrain.Bx
  alias DoomTrain.Route.Path

  @spec run(integer(), Date.t, Date.t) :: no_return()
  def run(pairing_id, from, to) do
    do_run(pairing_id, from, to)
  end

  def do_run(pairing_id, from, to) do
    if Timex.compare(from, to) == -1 do
      %{"data" => data} = Bx.historical_trade_data(pairing_id, from).body

      changeset = Path.changeset(%Path{}, %{
        station:     "BX",
        timestamp:   Timex.to_datetime(from),
        source:      "THB",
        destination: "ETH",

        average:     Map.get(data, "avg"),
        close:       Map.get(data, "close"),
        high:        Map.get(data, "high"),
        low:         Map.get(data, "low"),
        open:        Map.get(data, "open"),
        volume:      Map.get(data, "volume"),
      })

      if changeset.valid? do
        DoomTrain.Repo.insert(changeset)
      end

      :timer.sleep(2000)

      do_run(pairing_id, Timex.shift(from, days: 1), to)
    end
  end
end
