defmodule HoundPlayground.ChatController do
  use HoundPlayground.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
