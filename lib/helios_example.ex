defmodule HeliosExample do
  @moduledoc """
  CQRS Hello world application.

  ## Examples

      iex> params = %{"first_name" => "Test", "last_name" => "User", "email" => "email@example.com"}
      iex> HeliosExample.Facade.User.create_user(UUID.uuid4(), params)
      {:ok, :created}

  """
end
