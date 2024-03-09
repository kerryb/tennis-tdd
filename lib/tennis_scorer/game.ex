defmodule TennisScorer.Game do
  @moduledoc false
  defstruct [:player_one_name, :player_two_name, :player_one_score, :player_two_score]

  def new do
    %__MODULE__{player_one_name: "Player one", player_two_name: "Player two", player_one_score: 0, player_two_score: 0}
  end

  def award_point_to_player_one(game), do: Map.update!(game, :player_one_score, &(&1 + 1))

  def award_point_to_player_two(game), do: Map.update!(game, :player_two_score, &(&1 + 1))

  def reset_scores(game), do: %{game | player_one_score: 0, player_two_score: 0}

  def change_player_one_name(game, name), do: %{game | player_one_name: name}

  def change_player_two_name(game, name), do: %{game | player_two_name: name}

  def score(game) do
    cond do
      game_player_one?(game) -> game(game.player_one_name)
      game_player_two?(game) -> game(game.player_two_name)
      advantage_player_one?(game) -> advantage(game.player_one_name)
      advantage_player_two?(game) -> advantage(game.player_two_name)
      deuce?(game) -> deuce()
      true -> normal_score(game)
    end
  end

  defp game_player_one?(game), do: game.player_one_score > 3 and game.player_one_score - game.player_two_score > 1

  defp game_player_two?(game), do: game.player_two_score > 3 and game.player_two_score - game.player_one_score > 1

  defp advantage_player_one?(game), do: game.player_one_score > 3 and game.player_one_score > game.player_two_score

  defp advantage_player_two?(game), do: game.player_two_score > 3 and game.player_two_score > game.player_one_score

  defp deuce?(game), do: game.player_one_score > 3 and game.player_one_score == game.player_two_score

  defp game(name), do: "Game #{name}"

  defp advantage(name), do: "Advantage #{name}"

  defp deuce, do: "Deuce"

  defp normal_score(game), do: "#{score_value(game.player_one_score)} – #{score_value(game.player_two_score)}"

  defp score_value(0), do: 0
  defp score_value(1), do: 15
  defp score_value(2), do: 30
  defp score_value(3), do: 40
end
