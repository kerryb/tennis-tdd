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
    cond do
      game.score_1 > 3 and game.score_1 > game.score_2 + 1 ->
        "Game #{game.name_1}"

      game.score_2 > 3 and game.score_2 > game.score_1 + 1 ->
        "Game #{game.name_2}"

      game.score_1 > 3 and game.score_1 > game.score_2 ->
        "Advantage #{game.name_1}"

      game.score_2 > 3 ->
        "Advantage #{game.name_2}"

      game.score_1 == game.score_2 ->
        "#{String.capitalize(score_word(game.score_1))} all"

      true ->
        "#{String.capitalize(score_word(game.score_1))} #{score_word(game.score_2)}"
    end
  end

  defp score_word(score) do
    case score do
      0 -> "love"
      1 -> "fifteen"
      2 -> "thirty"
      3 -> "forty"
    end
  end
end
