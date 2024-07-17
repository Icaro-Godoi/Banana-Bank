defmodule BananaBankWeb.UsersControllerTest do
  alias BananaBank.ViaCep.ClientMock
  alias BananaBankWeb.Factory
  use BananaBankWeb.ConnCase

  import Factory
  import Mox

  setup :verify_on_exit!

  describe "create/2" do
    test "successfully creates an user", %{conn: conn} do
      expect(ClientMock, :call, fn "18040432" ->
        {:ok, ""}
      end)

      response =
        conn
        |> post(~p"/api/users", params_for(:user))
        |> json_response(:created)

      assert %{
               "data" => %{"cep" => "18040432", "email" => "example@frutas.com", "id" => _id, "name" => "Ícaro"},
               "message" => "Usuário criado com sucesso!"
             } = response
    end

    test "when there are invalid params, returns an error", %{conn: conn} do
      expect(ClientMock, :call, fn "123" ->
        {:ok, ""}
      end)

      response =
        conn
        |> post(~p"/api/users", params_for(:wrong_user))
        |> json_response(:bad_request)

      expected_response = %{"errors" => %{"cep" => ["should be 8 character(s)"], "name" => ["can't be blank"]}}

      assert expected_response == response
    end
  end

  describe "delete/1" do
    test "successfully deleted an user", %{conn: conn} do
      user = insert(:user)

      response =
        conn
        |> delete(~p"/api/users/#{user.id}")
        |> json_response(:ok)

      expected_response = %{
        "data" => %{"cep" => "18040432", "email" => "example@frutas.com", "id" => user.id, "name" => "Ícaro"},
        "message" => "Usuário deletado com sucesso!"
      }

      assert expected_response == response
    end

    test "if inserted an inexistent id, returns an error", %{conn: conn} do
      response =
        conn
        |> delete(~p"/api/users/999")
        |> json_response(:not_found)

      expected_response = %{
        "message" => "Usuário não encontrado",
        "status" => "not_found"
      }

      assert expected_response == response
    end
  end

  describe "update/2" do
    test "succesfully updated an user", %{conn: conn} do
      user = insert(:user)

      params = %{name: "Jonas"}

      response =
        conn
        |> put_req_header("content-type", "application/json")
        |> put(~p"/api/users/#{user.id}", params)
        |> json_response(:ok)

      expected_response = %{
        "message" => "Usuário atualizado com sucesso!",
        "data" => %{"cep" => "18040432", "email" => "example@frutas.com", "id" => user.id, "name" => "Jonas"}
      }

      assert expected_response == response
    end
  end
end
