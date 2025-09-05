defmodule TennisScorer.GameTest do
  use ExUnit.Case, async: true

  describe "TennisScorer.Game" do
    test "initialises to default names and zero scores" do
      assert %{name_1: "Player one", name_2: "Player two", score_1: 0, score_2: 0} = %TennisScorer.Game{}
    end
  end
end
