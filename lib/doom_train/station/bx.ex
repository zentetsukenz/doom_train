defmodule DoomTrain.Station.Bx do
  use Tesla

  plug Tesla.Middleware.BaseUrl, "https://bx.in.th/api"
  plug Tesla.Middleware.JSON

  adapter Tesla.Adapter.Hackney

  def market_data do
    get("")
  end
end
