defmodule TennisScorer.Game do
  @moduledoc false

  defstruct [:player_one_name, :player_two_name, :player_one_score, :player_two_score]

  def new,
    do: %__MODULE__{
      player_one_name: "Player one",
      player_two_name: "Player two",
      player_one_score: 0,
      player_two_score: 0
    }

  def award_point_to_player_one(game), do: Map.update!(game, :player_one_score, &(&1 + 1))

  def award_point_to_player_two(game), do: Map.update!(game, :player_two_score, &(&1 + 1))

  def reset_scores(game), do: %{game | player_one_score: 0, player_two_score: 0}

  def change_player_one_name(game, name), do: Map.put(game, :player_one_name, name)

  def change_player_two_name(game, name), do: Map.put(game, :player_two_name, name)

  def score(game) do
    cond do
      deuce?(game) -> deuce()
      game_player_one?(game) -> game(game.player_one_name)
      game_player_two?(game) -> game(game.player_two_name)
      advantage_player_one?(game) -> advantage(game.player_one_name)
      advantage_player_two?(game) -> advantage(game.player_two_name)
      true -> normal_score(game)
    end
  end

  defp deuce?(game), do: game.player_one_score == game.player_two_score && game.player_one_score > 3

  defp game_player_one?(game), do: game.player_one_score - game.player_two_score > 1 && game.player_one_score > 3

  defp game_player_two?(game), do: game.player_two_score - game.player_one_score > 1 && game.player_two_score > 3

  defp advantage_player_one?(game), do: game.player_one_score - game.player_two_score == 1 && game.player_one_score > 3

  defp advantage_player_two?(game), do: game.player_two_score - game.player_one_score == 1 && game.player_two_score > 3

  defp deuce, do: "Deuce"

  defp advantage(name), do: "Advantage #{name}"

  defp game(name), do: "Game #{name}"

  defp normal_score(game), do: "#{value(game.player_one_score)} – #{value(game.player_two_score)}"

  defp value(0), do: 0
  defp value(1), do: 15
  defp value(2), do: 30
  defp value(3), do: 40
end
