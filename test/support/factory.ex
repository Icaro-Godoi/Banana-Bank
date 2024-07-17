defmodule BananaBankWeb.Factory do
  use ExMachina.Ecto, repo: BananaBank.Repo

  def user_factory do
    %BananaBank.Users.User{
      name: "Ícaro",
      email: "example@frutas.com",
      cep: "18040432",
      password: sequence("senha_X"),
      password_hash: sequence("jfuihusngiurbngyvboufnruggjg489r4e1g9f6d8489eg45")
    }
  end

  def wrong_user_factory do
    %BananaBank.Users.User{
      name: nil,
      email: "example@frutas.com",
      cep: "123",
      password: sequence("senha_X"),
      password_hash: sequence("jfuihusngiurbngyvboufnruggjg489r4e1g9f6d8489eg45")
    }
  end
end
