defmodule ElixirCron.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do

    # List all child processes to be supervised
    children = [
      # Starts a worker by calling: ElixirCron.Worker.start_link(arg)
      # {ElixirCron.Worker, arg},

      # worker(ElixirCron.Scheduler, [])
      Supervisor.child_spec({ElixirCron.Scheduler, []}, type: :worker)
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ElixirCron.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def app_task do
    File.write("tmp/app_time.txt", "From the App #{Timex.now}\n", [:append])
  end
end
