defmodule TennisScorerWeb.ScoreboardLive do
  @moduledoc false
  use TennisScorerWeb, :live_view

  alias Phoenix.LiveView

  @impl LiveView
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(
       game: %{player_one_name: "Player one", player_two_name: "Player two", player_one_score: 0, player_two_score: 0}
     )
     |> build_form()}
  end

  @impl LiveView
  def handle_event("point-to-player-one", _unsigned_params, socket) do
    {:noreply, update(socket, :game, fn game -> Map.update!(game, :player_one_score, &(&1 + 1)) end)}
  end

  def handle_event("point-to-player-two", _unsigned_params, socket) do
    {:noreply, update(socket, :game, fn game -> Map.update!(game, :player_two_score, &(&1 + 1)) end)}
  end

  def handle_event("change", %{"_target" => ["player_one_name"], "player_one_name" => name}, socket) do
    {:noreply, socket |> update(:game, &Map.put(&1, :player_one_name, name)) |> build_form()}
  end

  def handle_event("change", %{"_target" => ["player_two_name"], "player_two_name" => name}, socket) do
    {:noreply, socket |> update(:game, &Map.put(&1, :player_two_name, name)) |> build_form()}
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

  attr :game, :map, required: true

  def score(assigns) do
    ~H"""
    <div class="mt-4 text-xl" id="score">
      <%= @game.player_one_name %> <%= @game.player_one_score %> – <%= @game.player_two_score %> <%= @game.player_two_name %>
    </div>
    """
  end
end
