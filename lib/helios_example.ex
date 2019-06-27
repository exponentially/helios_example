defmodule HeliosExample do
  @moduledoc """
  CQRS Hello world application.

  ## Examples

      iex> id = UUID.uuid4()
      iex> params = %{"first_name" => "Test", "last_name" => "User", "email" => "email@example.com"}
      iex> HeliosExample.Facade.User.create_user(id, params)
      {:ok, :created}
      iex> HeliosExample.Facade.User.update_email(id, %{"email" => "foo@example.com"})
      {:ok, :ok}

  """
end
