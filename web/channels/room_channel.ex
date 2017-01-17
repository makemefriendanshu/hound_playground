defmodule HoundPlayground.RoomChannel do
  use Phoenix.Channel

  def join("room:lobby", _message, socket) do
    {:ok, socket}
  end
  def join("room:" <> _private_room_id, _params, _socked) do
    {:error, %{reason: "unauthorized"}}
  end

  def handle_in("new_msg", %{"body" => body}, socket) do
    pid = Kernel.inspect(socket.transport_pid)
    broadcast! socket, "new_msg", %{body: body, pid: pid}
    {:noreply, socket}
  end
end
