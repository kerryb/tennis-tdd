defmodule TennisScorerWeb.ScoreboardLiveTest do
  use TennisScorerWeb.ConnCase, async: true

  import Phoenix.LiveViewTest

  @endpoint TennisScorerWeb.Endpoint

  describe "TennisScorerWeb.ScoreboardLive" do
    test "allows player names to be set", %{conn: conn} do
      {:ok, view, _html} = live(conn, "/")
      change_name(view, "player-1", "Alice")
      assert_name(view, "player-1", "Alice")

      change_name(view, "player-2", "Bob")
      assert_name(view, "player-2", "Bob")
    end

    test "tracks the score as points are scored", %{conn: conn} do
      {:ok, view, _html} = live(conn, "/")
      award_point(view, "player-1")
      assert_score(view, "fifteen love")
      award_point(view, "player-2")
      assert_score(view, "fifteen all")
    end

    test "disabled the scoring buttons once the game is one", %{conn: conn} do
      {:ok, view, _html} = live(conn, "/")
      award_point(view, "player-1")
      award_point(view, "player-1")
      award_point(view, "player-1")
      award_point(view, "player-1")
      assert_score_button_disabled(view, "player-1")
      assert_score_button_disabled(view, "player-2")
    end

    test "allows the scores to be reset", %{conn: conn} do
      {:ok, view, _html} = live(conn, "/")
      award_point(view, "player-1")
      award_point(view, "player-2")
      reset_scores(view)
      assert_score(view, "love all")
    end
  end

  defp change_name(view, player, name) do
    view |> element("a#edit-#{player}") |> render_click()
    view |> element("##{player} form") |> render_submit(%{"name" => name})
  end

  defp award_point(view, player) do
    view |> element("#point-to-#{player}") |> render_click()
  end

  defp reset_scores(view) do
    view |> element("#reset-scores") |> render_click()
  end

  defp assert_name(view, player, name) do
    assert has_element?(view, "##{player}", name)
  end

  defp assert_score(view, score) do
    assert view |> element("#score", score) |> has_element?()
  end

  defp assert_score_button_disabled(view, player) do
    assert view |> element("#point-to-#{player}[disabled]") |> has_element?()
  end
end
