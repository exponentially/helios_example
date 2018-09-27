defmodule HeliosExample do
  @moduledoc false
  require Logger
  @doc """
  Hello world.

  ## Examples

      iex> id = UUID.uuid4()
      iex> params = %{id: id, first_name: "first_name", last_name: "last_name", email: "email"}
      iex> HeliosExample.create_user(id, params) |> Map.get(:response)
      :created

  """
  def create_user(id, params) do
    ctx = %Helios.Context{
      adapter: {__MODULE__, %{id: id, params: params}},
      method: :execute,
      owner: self(),
      path_info: ["users", "#{id}", "create_user"],
      params: params
    }
    HeliosExample.Endpoint.call(ctx, [nest: "nesto"])
  end

  def send_resp(payload, status, ctx) do
    Logger.info({payload, status, ctx})
  end
end
