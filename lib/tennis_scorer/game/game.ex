defmodule TennisScorer.Game do
  @moduledoc false
  defstruct [:name_1, :name_2, :score_1, :score_2]

  def new(name_1, name_2) do
    %__MODULE__{name_1: name_1, name_2: name_2, score_1: 0, score_2: 0}
  end
end
