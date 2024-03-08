defmodule TennisScorer.Game do
  @moduledoc false
  defstruct [:player_one_name, :player_two_name, :player_one_score, :player_two_score]

  def score(game) do
    "#{game.player_one_name} #{game.player_one_score} – #{game.player_two_score} #{game.player_two_name}"
  end
end
