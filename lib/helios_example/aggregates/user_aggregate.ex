defmodule HeliosExample.Aggregates.UserAggregate do
  use Helios.Aggregate
  alias HeliosExample.Events.UserCreated
  alias HeliosExample.Events.UserEmailChanged
  require Logger

  # Aggregate State
  defstruct [:id, :first_name, :last_name, :email, :password]

  # Plugs for command context pipeline
  plug(Helios.Plugs.Logger, log_level: :debug)

  def persistance_id(id) do
    "users-#{id}"
  end

  def create_user(ctx, %{id: id, first_name: first_name, last_name: last_name, email: email}) do
    aggregate = state(ctx)

    if aggregate.id == id do
      ok(ctx, :created)
    else
      ctx
      |> emit(%UserCreated{user_id: id, first_name: first_name, last_name: last_name})
      |> emit(%UserEmailChanged{user_id: id, old_email: aggregate.email, new_email: email})
      |> ok(:created)
    end
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
end
