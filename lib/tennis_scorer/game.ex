defmodule TennisScorer.Game do
  @moduledoc false
  defstruct [:player_one_name, :player_two_name, :player_one_score, :player_two_score]

  def new, do: %{player_one_name: "Player one", player_two_name: "Player two", player_one_score: 0, player_two_score: 0}

  def award_point_to_player_one(game), do: Map.update!(game, :player_one_score, &(&1 + 1))

  def award_point_to_player_two(game), do: Map.update!(game, :player_two_score, &(&1 + 1))

  def reset_scores(game), do: %{game | player_one_score: 0, player_two_score: 0}

  def change_player_one_name(game, name), do: Map.put(game, :player_one_name, name)

  def change_player_two_name(game, name), do: Map.put(game, :player_two_name, name)

  def score(game) do
    cond do
      game?(game.player_one_score, game.player_two_score) -> game(game.player_one_name)
      game?(game.player_two_score, game.player_one_score) -> game(game.player_two_name)
      advantage?(game.player_one_score, game.player_two_score) -> advantage(game.player_one_name)
      advantage?(game.player_two_score, game.player_one_score) -> advantage(game.player_two_name)
      deuce?(game) -> deuce()
      true -> normal_score(game)
    end
  end

  defp advantage?(score_1, score_2), do: score_1 > 3 and score_1 > score_2

  defp game?(score_1, score_2), do: score_1 > 3 and score_1 - score_2 > 1

  defp deuce?(game), do: game.player_one_score > 3 and game.player_one_score == game.player_two_score

  defp advantage(name), do: "Advantage #{name}"

  defp game(name), do: "Game #{name}"

  defp deuce, do: "Deuce"

  defp normal_score(game), do: "#{value(game.player_one_score)} – #{value(game.player_two_score)}"

  defp value(0), do: 0
  defp value(1), do: 15
  defp value(2), do: 30
  defp value(3), do: 40
end
