defmodule TennisScorer.GameTest do
  use ExUnit.Case, async: true

  alias TennisScorer.Game

  describe "TennisScorer.award_point_to_player_1/1" do
    test "increments player 1’s score by 1" do
      game = %Game{score_1: 1}
      assert Game.award_point_to_player_1(game).score_1 == 2
    end
  end

  describe "TennisScorer.award_point_to_player_2/1" do
    test "increments player 2’s score by 1" do
      game = %Game{score_2: 1}
      assert Game.award_point_to_player_2(game).score_2 == 2
    end
  end

  describe "TennisScorer.reset_scores/1" do
    test "resets both players’ scores" do
      game = %Game{score_1: 1, score_2: 2}
      assert %{score_1: 0, score_2: 0} = Game.reset_scores(game)
    end
  end

  describe "TennisScorer.change_name_1/2" do
    test "updates player 1’s score by name" do
      game = Game.new()
      assert Game.change_name_1(game, "Alice").name_1 == "Alice"
    end
  end

  describe "TennisScorer.change_name_2/2" do
    test "updates player 2’s score by name" do
      game = Game.new()
      assert Game.change_name_2(game, "Bob").name_2 == "Bob"
    end
  end
end
