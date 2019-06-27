# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

# This configuration is loaded before any dependency and is restricted
# to this project. If another project depends on this project, this
# file won't be loaded nor affect the parent project. For this reason,
# if you want to provide default values for your application for
# 3rd-party users, it should be done in your "mix.exs" file.

# You can configure your application as:
#
#     config :helios_example, key: :value
#
# and access this configuration in your application as:
#
#     Application.get_env(:helios_example, :key)
#
# You can also configure a 3rd-party app:
#
config :logger, level: :info
#

# It is also possible to import configuration files, relative to this
# directory. For example, you can emulate configuration per environment
# by uncommenting the line below and defining dev.exs, test.exs and such.
# Configuration from the imported file will override the ones defined
# here (which is why it is important to import them last).
#
#     import_config "#{Mix.env}.exs"

config :extreme, :protocol_version, 4

config :helios,
  default_journal: HeliosExample.Journals.Eventstore,
  serve_endpoints: true,
  filter_parameters: [:password, "password", :credit_card_number]

config :helios, log_level: :debug

config :libcluster,
  topologies: [
    example: [
      # The selected clustering strategy. Required.
      strategy: Cluster.Strategy.Epmd,
      # Configuration for the provided strategy. Optional.
      config: [
        hosts: [
          :"helios_example_1@127.0.0.1",
          :"helios_example_2@127.0.0.1",
          :"helios_example_3@127.0.0.1"
        ]
      ],
      # The function to use for connecting nodes. The node
      # name will be appended to the argument list. Optional
      connect: {:net_kernel, :connect_node, []},
      # The function to use for disconnecting nodes. The node
      # name will be appended to the argument list. Optional
      disconnect: {:erlang, :disconnect_node, []},
      # The function to use for listing nodes.
      # This function must return a list of node names. Optional
      list_nodes: {:erlang, :nodes, [:connected]}
    ]
  ]

config :helios_example, HeliosExample.Journals.Eventstore,
  adapter: Helios.EventJournal.Adapter.Eventstore,
  adapter_config: [
    db_type: :node,
    host: "localhost",
    port: 1113,
    username: "admin",
    password: "changeit",
    connection_name: "helios_example",
    max_attempts: 10
  ]

config :helios_example, HeliosExample.Endpoint,
  code_reloader: true,
  journal: HeliosExample.Journals.Eventstore,
  registry: [
    sync_nodes_timeout: 5_000,
    retry_interval: 1_000,
    retry_max_attempts: 10,
    anti_entropy_interval: 5 * 60_000,
    distribution_strategy: {Helios.Registry.Distribution.Ring, :init, []}
  ]
