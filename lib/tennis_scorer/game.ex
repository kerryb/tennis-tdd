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
end
