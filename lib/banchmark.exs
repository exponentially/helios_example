
:observer.start()

Process.sleep(10_000)

opts = [
  warmup: 10,
  parallel: 100,
  time: 5
]

Benchee.run(
  %{
    "create_user" => fn ->
      params = %{
        "first_name" => "Test",
        "last_name" => "User",
        "email" => "email@example.com"
      }

      HeliosExample.Facade.User.create_user(UUID.uuid4(), params)
    end
  },
  opts
)
