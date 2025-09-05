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

  describe "TennisScorer.Game.set_player_1_name/2" do
    test "sets player one’s name" do
      game = Game.set_player_1_name(%Game{}, "Alice")
      assert game.name_1 == "Alice"
    end
  end

  describe "TennisScorer.Game.set_player_2_name/2" do
    test "sets player two’s name" do
      game = Game.set_player_2_name(%Game{}, "Bob")
      assert game.name_2 == "Bob"
    end
  end

  describe "TennisScorer.Game.score/1" do
    test "returns “Love all” for 0–0" do
      assert Game.score(%Game{score_1: 0, score_2: 0}) == "Love all"
    end

    test "returns “Fifteen love” for 1–0" do
      assert Game.score(%Game{score_1: 1, score_2: 0}) == "Fifteen love"
    end
  end
end
