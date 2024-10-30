defmodule TennisScorer.Game do
  @moduledoc false
  defstruct [:name_1, :name_2, :score_1, :score_2]

  def new(name_1, name_2) do
    %__MODULE__{name_1: name_1, name_2: name_2, score_1: 0, score_2: 0}
  end

  def award_point_to_player_1(game), do: Map.update!(game, :score_1, &(&1 + 1))

  def award_point_to_player_2(game), do: Map.update!(game, :score_2, &(&1 + 1))

  def reset_scores(game), do: %{game | score_1: 0, score_2: 0}

  def display_score(%{score_1: score, score_2: score}) when score > 3, do: "deuce"
  def display_score(%{score_1: score, name_1: name}) when score > 3, do: "advantage #{name}"
  def display_score(%{score_2: score, name_2: name}) when score > 3, do: "advantage #{name}"
  def display_score(%{score_1: score, score_2: score}), do: "#{label(score)} all"
  def display_score(%{score_1: score_1, score_2: score_2}), do: "#{label(score_1)} #{label(score_2)}"

  defp label(0), do: "love"
  defp label(1), do: "fifteen"
  defp label(2), do: "thirty"
  defp label(3), do: "forty"
end
