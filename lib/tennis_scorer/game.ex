defmodule TennisScorer.Game do
  @moduledoc false
  defstruct [:player_one_name, :player_two_name, :player_one_score, :player_two_score]

  def new do
    %__MODULE__{player_one_name: "Player one", player_two_name: "Player two", player_one_score: 0, player_two_score: 0}
  end
end
