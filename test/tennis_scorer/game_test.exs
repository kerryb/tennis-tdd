defmodule TennisScorer.GameTest do
  use ExUnit.Case, async: true

  alias TennisScorer.Game

  describe "TennisScorer.Game" do
    test "initialises to default names and zero scores" do
      assert %{name_1: "Player one", name_2: "Player two", score_1: 0, score_2: 0} = %Game{}
    end
  end

  describe "TennisScorer.Game.score_player_1/1" do
    test "increments player one’s score" do
      game = Game.score_player_1(%Game{score_1: 1})
      assert game.score_1 == 2
    end
  end

  describe "TennisScorer.Game.score_player_2/1" do
    test "increments player two’s score" do
      game = Game.score_player_2(%Game{score_2: 1})
      assert game.score_2 == 2
    end
  end
end
