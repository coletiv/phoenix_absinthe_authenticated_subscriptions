defmodule PhoenixAbsintheAuthenticatedSubscriptionsWeb.Endpoint do
  use Phoenix.Endpoint, otp_app: :phoenix_absinthe_authenticated_subscriptions
  use Absinthe.Phoenix.Endpoint

  socket "/socket", PhoenixAbsintheAuthenticatedSubscriptionsWeb.UserSocket,
    websocket: true,
    longpoll: false

  plug CORSPlug

  # Serve at "/" the static files from "priv/static" directory.
  #
  # You should set gzip to true if you are running phx.digest
  # when deploying your static files in production.
  plug Plug.Static,
    at: "/",
    from: :phoenix_absinthe_authenticated_subscriptions,
    gzip: false,
    only: ~w(css fonts images js favicon.ico robots.txt)

  # Code reloading can be explicitly enabled under the
  # :code_reloader configuration of your endpoint.
  if code_reloading? do
    plug Phoenix.CodeReloader
  end

  plug Plug.RequestId
  plug Plug.Logger

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Phoenix.json_library()

  plug Plug.MethodOverride
  plug Plug.Head

  # The session will be stored in the cookie and signed,
  # this means its contents can be read but not tampered with.
  # Set :encryption_salt if you would also like to encrypt it.
  plug Plug.Session,
    domain: Application.get_env(:phoenix_absinthe_authenticated_subscriptions, :cookie_domain),
    store: :cookie,
    secure: Application.get_env(:phoenix_absinthe_authenticated_subscriptions, :cookie_secure),
    max_age: 60 * 60 * 24 * 31,
    key: Application.get_env(:phoenix_absinthe_authenticated_subscriptions, :cookie_key),
    signing_salt: "Xr1b1Pgg"

  plug CORSPlug

  plug PhoenixAbsintheAuthenticatedSubscriptionsWeb.Router
end
