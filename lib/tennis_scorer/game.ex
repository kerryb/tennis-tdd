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
end
