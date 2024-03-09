defmodule TennisScorer.GameTest do
  use ExUnit.Case, async: true

  alias TennisScorer.Game

  describe "TennisScorer.Game.score/1" do
    test "scores 0 as 0" do
      game = Game.new()
      assert Game.score(game) == "0 – 0"
    end

    test "scores 1 as 15" do
      game = %Game{player_one_score: 1, player_two_score: 1}
      assert Game.score(game) == "15 – 15"
    end

    test "scores 2 as 30" do
      game = %Game{player_one_score: 2, player_two_score: 2}
      assert Game.score(game) == "30 – 30"
    end

    test "scores 3 as 40" do
      game = %Game{player_one_score: 3, player_two_score: 3}
      assert Game.score(game) == "40 – 40"
    end

    test "scores each player separately" do
      game = %Game{player_one_score: 2, player_two_score: 3}
      assert Game.score(game) == "30 – 40"
    end

    test "scores equal scores above 3 as deuce" do
      game = %Game{player_one_score: 4, player_two_score: 4}
      assert Game.score(game) == "Deuce"
    end

    test "scores advantage to player one if they’re ahead by one point and above 3" do
      game = %Game{player_one_name: "Alice", player_one_score: 5, player_two_score: 4}
      assert Game.score(game) == "Advantage Alice"
    end

    test "scores advantage to player two if they’re ahead by one point and above 3" do
      game = %Game{player_two_name: "Bob", player_one_score: 4, player_two_score: 5}
      assert Game.score(game) == "Advantage Bob"
    end

    test "scores game to player one if they’re ahead by more than one point and above 3" do
      game = %Game{player_one_name: "Alice", player_one_score: 6, player_two_score: 4}
      assert Game.score(game) == "Game Alice"
    end

    test "scores game to player two if they’re ahead by more than one point and above 3" do
      game = %Game{player_two_name: "Bob", player_one_score: 4, player_two_score: 6}
      assert Game.score(game) == "Game Bob"
    end
  end
end
