defmodule TennisScorer.GameTest do
  use ExUnit.Case, async: true

  alias TennisScorer.Game

  describe "TennisScorer.Game.score/1" do
    test "scores 0 as 0" do
      game = Game.new()
      assert Game.score(game) == "0 – 0"
    end

    test "scores 1 as 15" do
      game = %Game{player_one_score: 1, player_two_score: 0}
      assert Game.score(game) == "15 – 0"
    end

    test "scores 2 as 30" do
      game = %Game{player_one_score: 2, player_two_score: 0}
      assert Game.score(game) == "30 – 0"
    end

    test "scores 3 as 40" do
      game = %Game{player_one_score: 3, player_two_score: 0}
      assert Game.score(game) == "40 – 0"
    end

    test "shows both players’ scores" do
      game = %Game{player_one_score: 2, player_two_score: 1}
      assert Game.score(game) == "30 – 15"
    end

    test "shows advantage if player one is 4 – 3 up" do
      game = %Game{player_one_name: "Alice", player_one_score: 4, player_two_score: 3}
      assert Game.score(game) == "Advantage Alice"
    end

    test "shows advantage if player one is winning by a point and over 3" do
      game = %Game{player_one_name: "Alice", player_one_score: 5, player_two_score: 4}
      assert Game.score(game) == "Advantage Alice"
    end

    test "shows advantage if player two is 4 – 3 up" do
      game = %Game{player_two_name: "Bob", player_one_score: 3, player_two_score: 4}
      assert Game.score(game) == "Advantage Bob"
    end

    test "shows advantage if player two is winning by a point and over 3" do
      game = %Game{player_two_name: "Bob", player_one_score: 4, player_two_score: 5}
      assert Game.score(game) == "Advantage Bob"
    end

    test "shows game if player one is winning by more than a point and over 3" do
      game = %Game{player_one_name: "Alice", player_one_score: 6, player_two_score: 4}
      assert Game.score(game) == "Game Alice"
    end

    test "shows game if player two is winning by more than a point and over 3" do
      game = %Game{player_two_name: "Bob", player_one_score: 4, player_two_score: 6}
      assert Game.score(game) == "Game Bob"
    end

    test "shows deuce if scores are tied and over 3" do
      game = %Game{player_one_score: 4, player_two_score: 4}
      assert Game.score(game) == "Deuce"
    end
  end
end
