defmodule Hydchat.RoomChannel do
  use Phoenix.Channel

  def join(topic, _message, socket) do
    {:ok, socket}
  end

  def handle_in("get_welcome", payload, socket) do
    push socket, "info", %{body: "Welcome to Hyderabad Elixir Chat!"}
    {:noreply, socket}
  end

  def handle_in("new_msg", payload, socket) do
    IO.inspect(">>>>")
    IO.inspect [payload, socket]
    IO.inspect(">>>>")

    # Repository design pattern
    changeset = Hydchat.Message.changeset(%Hydchat.Message{}, %{"text" => payload["text"], "user" => payload["user"]})
    message = Hydchat.Repo.insert!(changeset)

    broadcast! socket, "recv_msg" ,payload
    {:noreply, socket}
  end


  # join(message_type, payload, socket)
  # handle_in(message_type, payload, socket)

end
