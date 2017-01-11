defmodule HoundPlayground.LoginController do
  require IEx
  use HoundPlayground.Web, :controller

  @user "tomsmith"
  @password "SuperSecretPassword!"

  def index(conn, _params) do
    render conn, "index.html"
  end

  def login(conn, %{"username" => @user, "password" => @password}) do
    conn
    |> put_session(:username, @user)
    |> redirect(to: secure_path(conn, :index))
  end
  def login(conn, %{"username" => @user}) do
    conn
    |> put_flash(:error, "Your password is invalid!")
    |> render("index.html")
  end
  def login(conn, _params) do
    conn
    |> put_flash(:error, "Your username is invalid!")
    |> render("index.html")
  end
end
