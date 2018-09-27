defmodule HeliosExample.Events.UserEmailChanged do
  defstruct [:user_id, :old_email, :new_email]
end
