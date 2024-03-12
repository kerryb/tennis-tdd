defmodule TennisScorer.Game do
  @moduledoc false
  defstruct [:name_1, :name_2, :score_1, :score_2]

  def new, do: %__MODULE__{name_1: "Player one", name_2: "Player two", score_1: 0, score_2: 0}

  def score(game), do: "#{game.name_1} #{game.score_1} – #{game.score_2} #{game.name_2}"

  def award_point_to_player_1(game), do: Map.update!(game, :score_1, &(&1 + 1))

  def award_point_to_player_2(game), do: Map.update!(game, :score_2, &(&1 + 1))

  def reset_scores(game), do: %{game | score_1: 0, score_2: 0}

  def change_name_1(game, name), do: Map.put(game, :name_1, name)

  def change_name_2(game, name), do: Map.put(game, :name_2, name)
end
