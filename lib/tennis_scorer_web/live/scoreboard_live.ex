defmodule TennisScorerWeb.ScoreboardLive do
  @moduledoc false
  use TennisScorerWeb, :live_view

  alias Phoenix.LiveView
  alias TennisScorer.Game

  @impl LiveView
  def mount(_params, _session, socket) do
    {:ok, socket |> assign(game: Game.new()) |> build_form()}
  end

  @impl LiveView
  def handle_event("point-to-player-one", _unsigned_params, socket) do
    {:noreply, update(socket, :game, &award_point_to_player_one/1)}
  end

  def handle_event("point-to-player-two", _unsigned_params, socket) do
    {:noreply, update(socket, :game, &award_point_to_player_two/1)}
  end

  def handle_event("reset-scores", _unsigned_params, socket) do
    {:noreply, update(socket, :game, &reset_scores/1)}
  end

  def handle_event("change", %{"_target" => ["player_one_name"], "player_one_name" => name}, socket) do
    {:noreply, socket |> update(:game, &change_player_one_name(&1, name)) |> build_form()}
  end

  def handle_event("change", %{"_target" => ["player_two_name"], "player_two_name" => name}, socket) do
    {:noreply, socket |> update(:game, &change_player_two_name(&1, name)) |> build_form()}
  end

  def handle_event(_event, _unsigned_params, socket), do: {:noreply, socket}

  defp build_form(socket) do
    assign(socket,
      form:
        to_form(%{
          "player_one_name" => socket.assigns.game.player_one_name,
          "player_two_name" => socket.assigns.game.player_two_name
        })
    )
  end

  defp award_point_to_player_one(game), do: Map.update!(game, :player_one_score, &(&1 + 1))

  defp award_point_to_player_two(game), do: Map.update!(game, :player_two_score, &(&1 + 1))

  defp reset_scores(game), do: %{game | player_one_score: 0, player_two_score: 0}

  defp change_player_one_name(game, name), do: Map.put(game, :player_one_name, name)

  defp change_player_two_name(game, name), do: Map.put(game, :player_two_name, name)
end
