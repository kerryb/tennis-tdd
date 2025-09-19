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
    for {score_1, score_2, expected} <- [
          {0, 0, "Love all"},
          {1, 1, "Fifteen all"},
          {2, 2, "Thirty all"},
          {3, 3, "Forty all"},
          {1, 0, "Fifteen love"},
          {2, 0, "Thirty love"},
          {3, 0, "Forty love"},
          {0, 1, "Love fifteen"},
          {0, 2, "Love thirty"},
          {0, 3, "Love forty"}
        ] do
      @score_1 score_1
      @score_2 score_2
      @expected expected
      test "returns “#{@expected}” for #{@score_1}–#{@score_2}" do
        assert Game.score(%Game{score_1: @score_1, score_2: @score_2}) == @expected
      end
    end

    test "returns advantage when player 1 is up 4–3" do
      assert Game.score(%Game{name_1: "Alice", score_1: 4, score_2: 3}) == "Advantage Alice"
    end

    test "returns advantage when player 1 is one point up and over 3" do
      assert Game.score(%Game{name_1: "Alice", score_1: 6, score_2: 5}) == "Advantage Alice"
    end
  end
end
