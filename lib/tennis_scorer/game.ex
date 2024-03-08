defmodule TennisScorer.Game do
  @moduledoc false
  defstruct [:player_one_name, :player_two_name, :player_one_score, :player_two_score]

  def score(game) do
    cond do
      player_one_has_won?(game) -> game(game.player_one_name)
      player_two_has_won?(game) -> game(game.player_two_name)
      advantage_player_one?(game) -> advantage(game.player_one_name)
      advantage_player_two?(game) -> advantage(game.player_two_name)
      deuce?(game) -> deuce()
      tied?(game) -> tied(game.player_one_score)
      true -> normal_score(game.player_one_score, game.player_two_score)
    end
  end

  defp player_one_has_won?(game), do: game.player_one_score > 3 and game.player_one_score - game.player_two_score > 1

  defp player_two_has_won?(game), do: game.player_two_score > 3 and game.player_two_score - game.player_one_score > 1

  defp advantage_player_one?(game), do: game.player_one_score > 3 and game.player_one_score > game.player_two_score

  defp advantage_player_two?(game), do: game.player_two_score > 3 and game.player_two_score > game.player_one_score

  defp deuce?(game), do: game.player_one_score > 2 and game.player_one_score == game.player_two_score

  defp tied?(game), do: game.player_one_score == game.player_two_score

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
