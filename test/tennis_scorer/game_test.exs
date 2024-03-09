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

  describe "TennisScorer.score/1" do
    test "returns ‘0 – 0’ for 0 points each" do
      game = %Game{player_one_score: 0, player_two_score: 0}
      assert Game.score(game) == "0 – 0"
    end

    test "returns ‘15’ for 1 point" do
      game = %Game{player_one_score: 1, player_two_score: 0}
      assert Game.score(game) == "15 – 0"
    end

    test "returns ‘30’ for 2 points" do
      game = %Game{player_one_score: 2, player_two_score: 0}
      assert Game.score(game) == "30 – 0"
    end

    test "returns ‘40’ for 3 points" do
      game = %Game{player_one_score: 3, player_two_score: 0}
      assert Game.score(game) == "40 – 0"
    end

    test "shows both players’ scores correctly" do
      game = %Game{player_one_score: 3, player_two_score: 2}
      assert Game.score(game) == "40 – 30"
    end

    test "returns ‘Advantage <player one>’ when player one is 4 – 3 ahead" do
      game = %Game{player_one_name: "Alice", player_one_score: 4, player_two_score: 3}
      assert Game.score(game) == "Advantage Alice"
    end

    test "returns ‘Advantage <player one>’ when player one is a point ahead with more than 4 points" do
      game = %Game{player_one_name: "Alice", player_one_score: 6, player_two_score: 5}
      assert Game.score(game) == "Advantage Alice"
    end

    test "returns ‘Advantage <player two>’ when player two is 4 – 3 ahead" do
      game = %Game{player_two_name: "Bob", player_one_score: 3, player_two_score: 4}
      assert Game.score(game) == "Advantage Bob"
    end

    test "returns ‘Advantage <player two>’ when player two is a point ahead with more than 4 points" do
      game = %Game{player_two_name: "Bob", player_one_score: 5, player_two_score: 6}
      assert Game.score(game) == "Advantage Bob"
    end

    test "returns ‘Deuce’ when Advantage <player two> yers are tied on more than 3 points" do
      game = %Game{player_one_score: 4, player_two_score: 4}
      assert Game.score(game) == "Deuce"
    end

    test "returns ‘Game <player one>’ when player one is more than a point ahead with more than 3 points" do
      game = %Game{player_one_name: "Alice", player_one_score: 5, player_two_score: 3}
      assert Game.score(game) == "Game Alice"
    end

    test "returns ‘Game <player two>’ when player two is more than a point ahead with more than 3 points" do
      game = %Game{player_two_name: "Bob", player_one_score: 3, player_two_score: 5}
      assert Game.score(game) == "Game Bob"
    end
  end
end
