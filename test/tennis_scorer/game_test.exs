defmodule TennisScorer.GameTest do
  use ExUnit.Case, async: true

  alias TennisScorer.Game

  describe "TennisScorer.Game.new/0" do
    test "defaults player_one_name to ‘Player one’" do
      assert Game.new().player_one_name == "Player one"
    end

    test "defaults player_two_name to ‘Player two’" do
      assert Game.new().player_two_name == "Player two"
    end

    test "defaults player_one_score to 0" do
      assert Game.new().player_one_score == 0
    end

    test "defaults player_two_score to 0" do
      assert Game.new().player_two_score == 0
    end
  end

  describe "TennisScorer.Game.award_point_to_player_one/1" do
    test "increments player one’s score" do
      game = Game.new()
      game = Game.award_point_to_player_one(game)
      assert game.player_one_score == 1
    end
  end

  describe "TennisScorer.Game.award_point_to_player_two/1" do
    test "increments player two’s score" do
      game = Game.new()
      game = Game.award_point_to_player_two(game)
      assert game.player_two_score == 1
    end
  end

  describe "TennisScorer.Game.reset_scores/1" do
    test "Resets both players’ scores" do
      game = %Game{player_one_score: 1, player_two_score: 2}
      game = Game.reset_scores(game)
      assert %{player_one_score: 0, player_two_score: 0} = game
    end
  end

  describe "TennisScorer.Game.change_player_one_name/2" do
    test "Updates player one’s name" do
      game = Game.new()
      game = Game.change_player_one_name(game, "Alice")
      assert %{player_one_name: "Alice"} = game
    end
  end

  describe "TennisScorer.Game.change_player_two_name/2" do
    test "Updates player two’s name" do
      game = Game.new()
      game = Game.change_player_two_name(game, "Bob")
      assert %{player_two_name: "Bob"} = game
    end
  end
end
