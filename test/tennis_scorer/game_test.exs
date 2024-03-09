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
end
