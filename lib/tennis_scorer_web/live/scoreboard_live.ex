defmodule TennisScorerWeb.ScoreboardLive do
  @moduledoc false
  use TennisScorerWeb, :live_view

  alias Phoenix.LiveView

  @impl LiveView
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(player_one_name: "Player one", player_two_name: "Player two", score: %{player_one: 0, player_two: 0})
     |> build_form()}
  end

  @impl LiveView
  def handle_event("point-to-player-one", _unsigned_params, socket) do
    {:noreply, update(socket, :score, fn score -> Map.update!(score, :player_one, &(&1 + 1)) end)}
  end

  def handle_event("point-to-player-two", _unsigned_params, socket) do
    {:noreply, update(socket, :score, fn score -> Map.update!(score, :player_two, &(&1 + 1)) end)}
  end

  def handle_event("change", %{"_target" => ["player_one_name"], "player_one_name" => name}, socket) do
    {:noreply, socket |> assign(player_one_name: name) |> build_form()}
  end

  def handle_event("change", %{"_target" => ["player_two_name"], "player_two_name" => name}, socket) do
    {:noreply, socket |> assign(player_two_name: name) |> build_form()}
  end

  def handle_event(_event, _unsigned_params, socket), do: {:noreply, socket}

  defp build_form(socket) do
    assign(socket,
      form:
        to_form(%{
          "player_one_name" => socket.assigns.player_one_name,
          "player_two_name" => socket.assigns.player_two_name
        })
    )
  end

  attr :player_one_name, :string, required: true
  attr :player_two_name, :string, required: true
  attr :score, :map, required: true

  def score(assigns) do
    ~H"""
    <div class="mt-4 text-xl" id="score">
      <%= @player_one_name %> <%= @score.player_one %> – <%= @score.player_two %> <%= @player_two_name %>
    </div>
    """
  end
end
