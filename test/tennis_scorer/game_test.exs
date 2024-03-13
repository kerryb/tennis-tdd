defmodule TennisScorer.GameTest do
  use ExUnit.Case, async: true

  alias TennisScorer.Game

  describe "TennisScorer.score/1" do
    test "scores 0 for 0" do
      game = %Game{score_1: 0, score_2: 0}
      assert Game.score(game) == "0 – 0"
    end

    test "scores 15 for 1" do
      game = %Game{score_1: 1, score_2: 1}
      assert Game.score(game) == "15 – 15"
    end

    test "scores 30 for 2" do
      game = %Game{score_1: 2, score_2: 2}
      assert Game.score(game) == "30 – 30"
    end

    test "scores 40 for 3" do
      game = %Game{score_1: 3, score_2: 3}
      assert Game.score(game) == "40 – 40"
    end

    test "scores each player independently" do
      game = %Game{score_1: 2, score_2: 3}
      assert Game.score(game) == "30 – 40"
    end

    test "scores advantage when player one is 4-3 up" do
      game = %Game{name_1: "Alice", score_1: 4, score_2: 3}
      assert Game.score(game) == "Advantage Alice"
    end
  end

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
