defmodule HeliosExample.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    topologies = Application.get_env(:libcluster, :topologies)

    children = [
      {HeliosExample.Journals.Eventstore, []},
      {HeliosExample.Endpoint, []},
      {Cluster.Supervisor, [topologies, [name: HeliosExample.ClusterSupervisor]]}
    ]

    opts = [strategy: :one_for_one, name: __MODULE__]
    Supervisor.start_link(children, opts)
  end
end
