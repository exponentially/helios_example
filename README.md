# Helios Example Application

Demonstrates capabilities of [helios framework](https://github.com/exponentially/helios)

NOTE: this is still in early development phase, so it may brake sometimes.

## How To Start

You need to install [Eventstore](https://eventstore.org) localy or check 
`config/config.exs` and change adapter_config to meet your instalation if eventstore 
is available on different network address.

Then clone this repo and run:

```bash
$ mix deps.get
$ mix compile
$ iex --name helios_example_1@127.0.0.1 -S mix helios.server
```

You can run up to 3 instances of this application (libcluster is configured that way).
```bash
$ iex --name helios_example_2@127.0.0.1 -S mix helios.server
```
```bash
$ iex --name helios_example_3@127.0.0.1 -S mix helios.server
```

from any iex console above, check functions that are available in `helios_example.ex` file. 
For instance you could run:

```elixir
iex> params = %{id: "1", first_name: "Test", last_name: "User", email: "email@example.com"}
iex> HeliosExample.create_user("1", params) |> Map.get(:response)
```
