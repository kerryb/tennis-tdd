defmodule TennisScorer.Game do
  @moduledoc false
  defstruct [:name_1, :name_2, :score_1, :score_2]

  def new(name_1, name_2) do
    %__MODULE__{name_1: name_1, name_2: name_2, score_1: 0, score_2: 0}
  end

  def award_point_to_player_1(game), do: Map.update!(game, :score_1, &(&1 + 1))

  def award_point_to_player_2(game), do: Map.update!(game, :score_2, &(&1 + 1))

  def reset_scores(game), do: %{game | score_1: 0, score_2: 0}

  def display_score(game) do
    cond do
      game.score_1 > 3 and game.score_1 > game.score_2 + 1 -> "game #{game.name_1}"
      game.score_2 > 3 and game.score_2 > game.score_1 + 1 -> "game #{game.name_2}"
      game.score_1 == game.score_2 and game.score_1 > 3 -> "deuce"
      game.score_1 > 3 -> "advantage #{game.name_1}"
      game.score_2 > 3 -> "advantage #{game.name_2}"
      game.score_1 == game.score_2 -> "#{label(game.score_1)} all"
      true -> "#{label(game.score_1)} #{label(game.score_2)}"
    end
  end

  defp label(0), do: "love"
  defp label(1), do: "fifteen"
  defp label(2), do: "thirty"
  defp label(3), do: "forty"

  def over?(game) do
    (game.score_1 > 3 and game.score_1 > game.score_2 + 1) or (game.score_2 > 3 and game.score_2 > game.score_1 + 1)
  end
end
