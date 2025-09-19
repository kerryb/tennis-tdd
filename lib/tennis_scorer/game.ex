defmodule TennisScorer.Game do
  @moduledoc false
  defstruct name_1: "Player one",
            name_2: "Player two",
            score_1: 0,
            score_2: 0

  def score_player_1(game) do
    Map.update!(game, :score_1, fn score -> score + 1 end)
  end

  def score_player_2(game) do
    Map.update!(game, :score_2, fn score -> score + 1 end)
  end

  def set_player_1_name(game, name) do
    %{game | name_1: name}
  end

  def set_player_2_name(game, name) do
    %{game | name_2: name}
  end

  def score(game) do
    cond_result =
      cond do
        game.score_1 > 0 ->
          "#{score_word(game.score_1)} love"

        game.score_2 > 0 ->
          "love #{score_word(game.score_2)}"

        true ->
          "love all"
      end

    String.capitalize(cond_result)
  end

  defp score_word(score) do
    case score do
      1 -> "Fifteen"
      2 -> "Thirty"
      3 -> "Forty"
    end
  end
end
