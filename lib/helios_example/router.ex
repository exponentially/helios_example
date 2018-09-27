defmodule HeliosExample.Router do
  use Helios.Router

  aggregate "/users", HeliosExample.Aggregates.UserAggregate, only: [
    :create_user
  ]
end
