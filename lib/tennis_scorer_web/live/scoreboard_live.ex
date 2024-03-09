defmodule TennisScorerWeb.ScoreboardLive do
  @moduledoc false
  use TennisScorerWeb, :live_view

  alias Phoenix.LiveView
  alias TennisScorer.Game

  @impl LiveView
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(game: Game.new())
     |> build_form()}
  end

  @impl LiveView
  def handle_event("point-to-player-one", _unsigned_params, socket) do
    {:noreply, update(socket, :game, &Game.award_point_to_player_one/1)}
  end

  def handle_event("point-to-player-two", _unsigned_params, socket) do
    {:noreply, update(socket, :game, &Game.award_point_to_player_two/1)}
  end

  def handle_event("reset-scores", _unsigned_params, socket) do
    {:noreply, update(socket, :game, &Game.reset_scores/1)}
  end

  def handle_event("change", %{"_target" => ["player_one_name"], "player_one_name" => name}, socket) do
    {:noreply, socket |> update(:game, &Game.change_player_one_name(&1, name)) |> build_form()}
  end

  def handle_event("change", %{"_target" => ["player_two_name"], "player_two_name" => name}, socket) do
    {:noreply, socket |> update(:game, &Game.change_player_two_name(&1, name)) |> build_form()}
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
end
