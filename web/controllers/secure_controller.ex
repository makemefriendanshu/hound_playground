defmodule HoundPlayground.SecureController do
  use HoundPlayground.Web, :controller

  def index(conn, _params) do
    case get_session(conn, :username) do
      nil -> 
        conn
        |> put_flash(:error, "You must login to view the secure area!")
        |> redirect(to: login_path(conn, :index))
      _ ->
        conn 
        |> put_flash(:info, "You logged into a secure area!")
        |> render("index.html")
    end
  end

  def logout(conn, _params) do
    conn
    |> delete_session(:username)
    |> put_flash(:info, "You logged out of the secure area!")
    |> redirect(to: login_path(conn, :index))
  end
end
