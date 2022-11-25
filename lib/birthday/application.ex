defmodule Birthday.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    IO.puts "Server running on port: 8000"
    children = [
      # Starts a worker by calling: Birthday.Worker.start_link(arg)
      # {Birthday.Worker, arg}
      {Plug.Cowboy, scheme: :http, plug: Birthday.Router, options: [port: 8000]},
      {Aggregator, []}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one]
    Supervisor.start_link(children, opts)
  end
end
