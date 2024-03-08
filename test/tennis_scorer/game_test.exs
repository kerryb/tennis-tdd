defmodule TennisScorer.GameTest do
  use ExUnit.Case

  alias TennisScorer.Game

  describe "TennisScorer.Game.score/1" do
    test "returns ‘Love all’ for 0 – 0" do
      game = %Game{player_one_name: "Alice", player_two_name: "Bob", player_one_score: 0, player_two_score: 0}
      assert Game.score(game) == "Love all"
    end

    test "returns ‘Love 15’ for 0 – 1" do
      game = %Game{player_one_name: "Alice", player_two_name: "Bob", player_one_score: 0, player_two_score: 1}
      assert Game.score(game) == "Love 15"
    end

    test "returns ‘15 love’ for 1 – 0" do
      game = %Game{player_one_name: "Alice", player_two_name: "Bob", player_one_score: 1, player_two_score: 0}
      assert Game.score(game) == "15 love"
    end

    test "returns ‘15 30’ for 1 – 2" do
      game = %Game{player_one_name: "Alice", player_two_name: "Bob", player_one_score: 1, player_two_score: 2}
      assert Game.score(game) == "15 30"
    end

    test "returns ‘40 30’ for 3 – 2" do
      game = %Game{player_one_name: "Alice", player_two_name: "Bob", player_one_score: 3, player_two_score: 2}
      assert Game.score(game) == "40 30"
    end

    test "returns ‘15 all’ for 1 – 1" do
      game = %Game{player_one_name: "Alice", player_two_name: "Bob", player_one_score: 1, player_two_score: 1}
      assert Game.score(game) == "15 all"
    end

    test "returns ‘Advantage <player one>’ for 4 – 3" do
      game = %Game{player_one_name: "Alice", player_two_name: "Bob", player_one_score: 4, player_two_score: 3}
      assert Game.score(game) == "Advantage Alice"
    end

    test "continues to return advantage while player one is one point ahead" do
      game = %Game{player_one_name: "Alice", player_two_name: "Bob", player_one_score: 6, player_two_score: 5}
      assert Game.score(game) == "Advantage Alice"
    end

    test "returns ‘Game <player one>’ when player one is two points ahead and > 3 points" do
      game = %Game{player_one_name: "Alice", player_two_name: "Bob", player_one_score: 4, player_two_score: 2}
      assert Game.score(game) == "Game Alice"
    end

    test "returns ‘Advantage <player two>’ for 3 – 4" do
      game = %Game{player_one_name: "Alice", player_two_name: "Bob", player_one_score: 3, player_two_score: 4}
      assert Game.score(game) == "Advantage Bob"
    end

    test "continues to return advantage while player two is one point ahead" do
      game = %Game{player_one_name: "Alice", player_two_name: "Bob", player_one_score: 5, player_two_score: 6}
      assert Game.score(game) == "Advantage Bob"
    end

    test "returns ‘Deuce’ when players are tied on > 2 points" do
      game = %Game{player_one_name: "Alice", player_two_name: "Bob", player_one_score: 3, player_two_score: 3}
      assert Game.score(game) == "Deuce"
    end

    test "returns ‘Game <player two>’ when player two is two points ahead and > 3 points" do
      game = %Game{player_one_name: "Alice", player_two_name: "Bob", player_one_score: 2, player_two_score: 4}
      assert Game.score(game) == "Game Bob"
    end
  end
end
