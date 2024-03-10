defmodule TennisScorer.GameTest do
  use ExUnit.Case, async: true

  alias TennisScorer.Game

  describe "TennisScorer.Game.score/1" do
    test "scores 0 for 0 points" do
      game = Game.new()
      assert Game.score(game) == "0 – 0"
    end

    test "scores 15 for 1 point" do
      game = %Game{player_one_score: 1, player_two_score: 1}
      assert Game.score(game) == "15 – 15"
    end

    test "scores 30 for 2 points" do
      game = %Game{player_one_score: 2, player_two_score: 2}
      assert Game.score(game) == "30 – 30"
    end

    test "scores 40 for 3 points" do
      game = %Game{player_one_score: 3, player_two_score: 3}
      assert Game.score(game) == "40 – 40"
    end

    test "scores games when players have different points" do
      game = %Game{player_one_score: 2, player_two_score: 3}
      assert Game.score(game) == "30 – 40"
    end

    test "scores advantage when player one is one point ahead and on more than 3 points" do
      game = %Game{player_one_name: "Alice", player_one_score: 4, player_two_score: 3}
      assert Game.score(game) == "Advantage Alice"
    end

    test "scores advantage when player two is one point ahead and on more than 3 points" do
      game = %Game{player_two_name: "Bob", player_one_score: 3, player_two_score: 4}
      assert Game.score(game) == "Advantage Bob"
    end
  end
end
