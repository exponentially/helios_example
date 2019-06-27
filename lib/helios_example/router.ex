defmodule HeliosExample.Router do
  use Helios.Router
  require Logger

  pipeline :test do
    plug :log_hello
  end

  scope "/" do
    pipe_through(:test)
    aggregate "/users", HeliosExample.Aggregates.UserAggregate, only: [
      :create_user,
      :update_email
    ]
  end


  def log_hello(ctx, _) do
    Logger.info("hello")
    ctx
  end
end
