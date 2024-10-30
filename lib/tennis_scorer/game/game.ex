defmodule TennisScorer.Game do
  @moduledoc false
  defstruct [:name_1, :name_2, :score_1, :score_2]

  def new(name_1, name_2) do
    %__MODULE__{name_1: name_1, name_2: name_2, score_1: 0, score_2: 0}
  end

  def award_point_to_player_1(game), do: Map.update!(game, :score_1, &(&1 + 1))

  def award_point_to_player_2(game), do: Map.update!(game, :score_2, &(&1 + 1))

  def reset_scores(game), do: %{game | score_1: 0, score_2: 0}
end
