defmodule TennisScorer.Game do
  @moduledoc false
  defstruct [:player_one_name, :player_two_name, :player_one_score, :player_two_score]

  def score(game) do
    cond do
      game.player_one_score > 3 and game.player_one_score - game.player_two_score > 1 ->
        game(game.player_one_name)

      game.player_two_score > 3 and game.player_two_score - game.player_one_score > 1 ->
        game(game.player_two_name)

      game.player_one_score > 3 and game.player_one_score > game.player_two_score ->
        advantage(game.player_one_name)

      game.player_two_score > 3 and game.player_two_score > game.player_one_score ->
        advantage(game.player_two_name)

      game.player_one_score > 3 ->
        deuce()

      game.player_one_score == game.player_two_score ->
        tied(game.player_one_score)

      true ->
        normal_score(game.player_one_score, game.player_two_score)
    end
  end

  defp game(name), do: "Game #{name}"
  defp advantage(name), do: "Advantage #{name}"

  defp deuce, do: "Deuce"

  defp tied(score), do: String.capitalize("#{score_for(score)} all")

  defp normal_score(player_one_score, player_two_score) do
    String.capitalize("#{score_for(player_one_score)} #{score_for(player_two_score)}")
  end

  defp score_for(0), do: "love"
  defp score_for(1), do: "15"
  defp score_for(2), do: "30"
  defp score_for(3), do: "40"
end
