defmodule TennisScorer.GameTest do
  use ExUnit.Case, async: true

  alias TennisScorer.Game

  describe "TennisScorer.Game.new/2" do
    test "initialises both scores to zero" do
      assert %{name_1: "Alice", name_2: "Bob", score_1: 0, score_2: 0} = Game.new("Alice", "Bob")
    end
  end

  describe "TennisScorer.Game.award_point_to_player_1/1" do
    test "increments player 1’s score" do
      game = Game.new("Alice", "Bob")
      assert Game.award_point_to_player_1(game).score_1 == 1
    end
  end

  describe "TennisScorer.Game.award_point_to_player_2/1" do
    test "increments player 2’s score" do
      game = Game.new("Alice", "Bob")
      assert Game.award_point_to_player_2(game).score_2 == 1
    end
  end

  describe "TennisScorer.Game.reset_scores/1" do
    test "resets both player 2’s scores to zero" do
      game = %Game{score_1: 0, score_2: 0}
      assert %{score_1: 0, score_2: 0} = Game.reset_scores(game)
    end
  end

  describe "TennisScorer.Game.display_score/1" do
    for {score_1, score_2, display} <- [
          {0, 0, "love all"},
          {1, 0, "fifteen love"},
          {0, 1, "love fifteen"},
          {1, 1, "fifteen all"},
          {2, 2, "thirty all"},
          {3, 3, "forty all"},
          {4, 4, "deuce"},
          {5, 5, "deuce"},
          {4, 3, "advantage Alice"},
          {3, 4, "advantage Bob"},
          {4, 2, "game Alice"},
          {5, 3, "game Alice"},
          {2, 4, "game Bob"},
          {3, 5, "game Bob"}
        ] do
      @score_1 score_1
      @score_2 score_2
      @display display

      test "returns ‘#{@display}’ for #{@score_1} – #{@score_2}" do
        assert Game.display_score(%Game{name_1: "Alice", name_2: "Bob", score_1: @score_1, score_2: @score_2}) == @display
      end
    end
  end

  describe "TennisScorer.Game.over?/1" do
    test "is false when no player has reached 4 points" do
      refute Game.over?(%Game{score_1: 0, score_2: 3})
    end

    test "is false at deuce" do
      refute Game.over?(%Game{score_1: 4, score_2: 4})
    end

    test "is false at advantage for player 1" do
      refute Game.over?(%Game{score_1: 5, score_2: 4})
    end

    test "is false at advantage for player 2" do
      refute Game.over?(%Game{score_1: 4, score_2: 5})
    end

    test "is true at game for player 1" do
      assert Game.over?(%Game{score_1: 5, score_2: 3})
    end
  end
end
