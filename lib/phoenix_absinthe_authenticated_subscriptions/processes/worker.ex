defmodule PhoenixAbsintheAuthenticatedSubscriptions.Processes.Worker do
  @moduledoc """
  Module worker
  """

  alias PhoenixAbsintheAuthenticatedSubscriptions.Accounts

  use GenServer, restart: :transient

  def start_link(init_arg) do
    GenServer.start_link(__MODULE__, init_arg, name: :worker)
  end

  def init(state) do
    # Schedule worker
    schedule_user_worker()
    {:ok, state}
  end

  def handle_info(:reschedule, state) do
    Accounts.list_users()
    |> Enum.map(fn %{id: id} ->
      Absinthe.Subscription.publish(PhoenixAbsintheAuthenticatedSubscriptionsWeb.Endpoint, Enum.random(1..10),
        accounts_user_count: "user_count:#{id}"
      )
    end)

    schedule_user_worker()

    {:noreply, state}
  end

  defp schedule_user_worker do
    time = calculate_next_schedule()
    Process.send_after(self(), :reschedule, time)
  end

  defp calculate_next_schedule do
    # Calculate hour - [ms * sec]
    1000 * 10
  end
end
