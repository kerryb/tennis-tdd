defmodule TennisScorer.Game do
  @moduledoc false

  defstruct [:name_1, :name_2, :score_1, :score_2]

  def new, do: %__MODULE__{name_1: "Player one", name_2: "Player two", score_1: 0, score_2: 0}

  def award_point_to_player_1(game), do: Map.update!(game, :score_1, &(&1 + 1))

  def award_point_to_player_2(game), do: Map.update!(game, :score_2, &(&1 + 1))

  def reset_scores(game), do: %{game | score_1: 0, score_2: 0}

  def change_name_1(game, name), do: Map.put(game, :name_1, name)

  def change_name_2(game, name), do: Map.put(game, :name_2, name)

  def score(game) do
    cond do
      win?(game.score_1, game.score_2) ->
        "Game #{game.name_1}"

      win?(game.score_2, game.score_1) ->
        "Game #{game.name_2}"

      advantage?(game.score_1, game.score_2) ->
        "Advantage #{game.name_1}"

      advantage?(game.score_2, game.score_1) ->
        "Advantage #{game.name_2}"

      true ->
        "#{value(game.score_1)} – #{value(game.score_2)}"
    end
  end

  defp win?(score_1, score_2), do: score_1 > 3 and score_1 - score_2 > 1

  defp advantage?(score_1, score_2), do: score_1 > 3 and score_1 - score_2 == 1

  defp value(0), do: 0
  defp value(1), do: 15
  defp value(2), do: 30
  defp value(3), do: 40
end
