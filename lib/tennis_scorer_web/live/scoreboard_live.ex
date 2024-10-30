defmodule TennisScorerWeb.ScoreboardLive do
  @moduledoc false
  use TennisScorerWeb, :live_view

  alias Phoenix.LiveView
  alias TennisScorer.Game

  @impl LiveView
  def mount(_params, _session, socket) do
    {:ok,
     assign(socket,
       game: Game.new("Player one", "Player two"),
       edit_player_1?: false,
       edit_player_2?: false
     )}
  end

  @impl LiveView
  def handle_event("edit-player-1", _unsigned_params, socket) do
    {:noreply, assign(socket, edit_player_1?: true)}
  end

  def handle_event("edit-player-2", _unsigned_params, socket) do
    {:noreply, assign(socket, edit_player_2?: true)}
  end

  def handle_event("point-to-player-1", _unsigned_params, socket) do
    {:noreply, update(socket, :game, &Game.award_point_to_player_1/1)}
  end

  def handle_event("point-to-player-2", _unsigned_params, socket) do
    {:noreply, update(socket, :game, &Game.award_point_to_player_2/1)}
  end

  def handle_event("reset-scores", _unsigned_params, socket) do
    {:noreply, update(socket, :game, &Game.reset_scores/1)}
  end

  def handle_event("submit-player-1", %{"name" => name}, socket) do
    {:noreply, socket |> update(:game, &%{&1 | name_1: name}) |> assign(edit_player_1?: false)}
  end

  def handle_event("submit-player-2", %{"name" => name}, socket) do
    {:noreply, socket |> update(:game, &%{&1 | name_2: name}) |> assign(edit_player_2?: false)}
  end
end
