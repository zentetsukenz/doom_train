defmodule DoomTrain.Bx do
  use Tesla

  plug Tesla.Middleware.BaseUrl, "https://bx.in.th/api"
  plug Tesla.Middleware.JSON

  adapter Tesla.Adapter.Hackney

  @spec market_data :: Tesla.Env.t
  def market_data do
    get("")
  end

  @spec currency_pairings :: Tesla.Env.t
  def currency_pairings do
    get("/pairing")
  end

  @spec order_book(integer()) :: Tesla.Env.t
  def order_book(pairing_id) do
    get("/orderbook/?pairing=" <> to_string(pairing_id))
  end

  @spec recent_trades(integer()) :: Tesla.Env.t
  def recent_trades(pairing_id) do
    get("/trade/?pairing=" <> to_string(pairing_id))
  end

  @spec historical_trade_data(integer(), Date.t) :: Tesla.Env.t
  def historical_trade_data(pairing_id, date) do
    get("/tradehistory/?pairing=" <> to_string(pairing_id) <> "&date=" <> Date.to_string(date))
  end
end
