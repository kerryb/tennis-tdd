defmodule TennisScorer.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      TennisScorerWeb.Telemetry,
      {DNSCluster, query: Application.get_env(:tennis_scorer, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: TennisScorer.PubSub},
      # Start a worker by calling: TennisScorer.Worker.start_link(arg)
      # {TennisScorer.Worker, arg},
      # Start to serve requests, typically the last entry
      TennisScorerWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: TennisScorer.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    TennisScorerWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
