defmodule DoomTrain.Bx.Hyperparameter do
  @type t :: %__MODULE__{
    learning_rate: float(),
    discount_rate: float(),
  }

  defstruct learning_rate: 0.2, discount_rate: 0.9
end
