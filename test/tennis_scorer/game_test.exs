defmodule TennisScorer.GameTest do
  use ExUnit.Case

  alias TennisScorer.Game

  describe "TennisScorer.Game.score/1" do
    test "scores 0 for 0" do
      game = Game.new()
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

    test "scores players independently" do
      game = %Game{score_1: 3, score_2: 2}
      assert Game.score(game) == "40 – 30"
    end

    test "scores advantage when player 1 is 4-3 up" do
      game = %Game{name_1: "Alice", score_1: 4, score_2: 3}
      assert Game.score(game) == "Advantage Alice"
    end

    test "scores advantage when player 1 is a point up and over 4" do
      game = %Game{name_1: "Alice", score_1: 5, score_2: 4}
      assert Game.score(game) == "Advantage Alice"
    end

    test "scores a win when player 1 is two points up and over 3" do
      game = %Game{name_1: "Alice", score_1: 5, score_2: 3}
      assert Game.score(game) == "Game Alice"
    end

    test "scores advantage when player 2 is 4-3 up" do
      game = %Game{name_2: "Bob", score_1: 3, score_2: 4}
      assert Game.score(game) == "Advantage Bob"
    end

    test "scores advantage when player 2 is a point up and over 4" do
      game = %Game{name_2: "Bob", score_1: 4, score_2: 5}
      assert Game.score(game) == "Advantage Bob"
    end

    test "scores a win when player 2 is two points up and over 3" do
      game = %Game{name_2: "Bob", score_1: 3, score_2: 5}
      assert Game.score(game) == "Game Bob"
    end
  end
end
