defmodule BananaBankWeb.WellcomeController do
  use BananaBankWeb, :controller

  def index(conn, _params) do
    conn
    |> put_status(:ok)
    |> json(%{message: "Seja bem vindo(a) ao BananaBank!"})
  end
end
