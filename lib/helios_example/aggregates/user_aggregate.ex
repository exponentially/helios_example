defmodule HeliosExample.Aggregates.UserAggregate do
  use Helios.Aggregate

  alias HeliosExample.Events.UserCreated
  alias HeliosExample.Events.UserEmailChanged
  require Logger

  # Aggregate State
  defstruct [:id, :first_name, :last_name, :email, :enabled?, :password]

  # Plugs for command context pipeline
  plug(Helios.Plugs.Logger, log_level: :debug)
  plug(:not_found, [] when not (handler in [:create_user]))
  plug(:preven_duplicates, [] when handler in [:create_user])

  def persistance_id(id), do: "users-#{id}"

  def new(_) do
    {:ok, struct!(__MODULE__, [])}
  end


  def create_user(ctx, %{
        "id" => id,
        "first_name" => first_name,
        "last_name" => last_name,
        "email" => email
      }) do
    ctx
    |> emit(%UserCreated{user_id: id, first_name: first_name, last_name: last_name})
    |> emit(%UserEmailChanged{user_id: id, old_email: nil, new_email: email})
    |> ok(:created)
  end

  def update_email(ctx, %{"id" => id, "email" => email}) do
    aggregate = state(ctx)

    ctx
    |> emit(%UserEmailChanged{user_id: id, old_email: aggregate.email, new_email: email})
    |> ok(:ok)
  end

  def apply_event(%UserCreated{} = event, agg) do
    %{
      agg
      | id: event.user_id,
        first_name: event.first_name,
        last_name: event.last_name
    }
  end

  def apply_event(%UserEmailChanged{} = event, agg) do
    %{agg | email: event.new_email}
  end

  def apply_event(e, agg) do
    Logger.info("SKIPPING #{inspect(e)}")
    agg
  end

  defp not_found(ctx, []) do
    if is_nil(state(ctx).id) do
      ctx
      |> halt()
      |> error(:not_found)
    else
      ctx
    end
  end

  defp preven_duplicates(ctx, []) do
    unless is_nil(state(ctx).id) do
      ctx
      |> halt()
      |> ok(:created)
    else
      ctx
    end
  end
end
