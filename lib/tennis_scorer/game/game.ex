defmodule TennisScorer.Game do
  @moduledoc false
  defstruct [:name_1, :name_2, :score_1, :score_2]

  def new(name_1, name_2) do
    %__MODULE__{name_1: name_1, name_2: name_2, score_1: 0, score_2: 0}
  end

  def award_point_to_player_1(game), do: Map.update!(game, :score_1, &(&1 + 1))

  def award_point_to_player_2(game), do: Map.update!(game, :score_2, &(&1 + 1))

  def reset_scores(game), do: %{game | score_1: 0, score_2: 0}

  def display_score(%{score_1: 0, score_2: 0}), do: "love all"
  def display_score(%{score_1: 1, score_2: 0}), do: "fifteen love"
  def display_score(%{score_1: 0, score_2: 1}), do: "love fifteen"
  def display_score(%{score_1: 1, score_2: 1}), do: "fifteen all"
end
