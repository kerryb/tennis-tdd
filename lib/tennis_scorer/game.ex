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
end
