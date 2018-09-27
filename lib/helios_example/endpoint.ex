defmodule HeliosExample.Endpoint do
  use Helios.Endpoint, otp_app: :helios_example

  plug HeliosExample.Router
end
