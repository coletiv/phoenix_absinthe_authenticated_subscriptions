# PhoenixAbsintheAuthenticatedSubscriptions

Phoenix absinthe authenticated subscriptions article

## 🚧 Dependencies

- Elixir (`~> 1.10`)
- Erlang (`~> 22.0`)
- PostgreSQL (`~> 10.6`)

## 🏎 Kickstart

### Environment variables

We are not using many environemnt variables for now, meaning you have to manually create the `*.secret.exs` files and add them to the server or injecting variables somehow.

### Initial setup

1. Install Mix dependencies with `mix deps.get`
2. Create and migrate the database with `mix ecto.setup`
3. Start the Phoenix server with `iex -S mix phx.server`

### Verify

Enter on http://localhost:4000/v1/graphiql and import this workspace (https://gist.github.com/marinho10/cdb0814eea1ad1aba9b8faa2048d67aa).

1. Run "mutation - accountsLogin"
2. Run "query - accountsMe" and copy token returned
3. Change ws url token on "subscription - accountsUserCount" and run
4. Verify "accountsUserCount" value changing every 10 seconds on "subscription - accountsUserCount"
