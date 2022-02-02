defmodule DevCilada.Repo do
  use Ecto.Repo,
    otp_app: :dev_cilada,
    adapter: Ecto.Adapters.Postgres
end
