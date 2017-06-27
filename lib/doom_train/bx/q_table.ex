defmodule DoomTrain.Bx.QTable do
  @type adj_close_sma_ratio :: integer()
  @type holding             :: boolean()
  @type return_since_entry  :: integer()

  @type state               :: {adj_close_sma_ratio, holding, return_since_entry}
  @type actions             :: {:buy, :sell, :nothing}
  @type t                   :: Map.t
end
