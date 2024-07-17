defmodule BananaBankWeb.UsersJSON do
  alias BananaBank.Users.User

  def create(%{user: user}) do
    %{
      message: "Usuário criado com sucesso!",
      data: data(user)
    }
  end

  def login(%{token: token}) do
    %{
      message: "Usuário autenticado com sucesso!",
      bearer: token
    }
  end

  def delete(%{user: user}), do: %{message: "Usuário deletado com sucesso!", data: data(user)}
  def get(%{user: user}), do: %{data: data(user)}
  def update(%{user: user}), do: %{message: "Usuário atualizado com sucesso!", data: data(user)}

  defp data(%User{} = user) do
    %{
      id: user.id,
      name: user.name,
      email: user.email,
      cep: user.cep
    }
  end
end
