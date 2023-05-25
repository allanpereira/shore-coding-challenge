defmodule BowlingGame.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      BowlingGameWeb.Telemetry,
      # Start Finch
      {Finch, name: BowlingGame.Finch},
      # Start the Endpoint (http/https)
      BowlingGameWeb.Endpoint
      # Start a worker by calling: BowlingGame.Worker.start_link(arg)
      # {BowlingGame.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: BowlingGame.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    BowlingGameWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
