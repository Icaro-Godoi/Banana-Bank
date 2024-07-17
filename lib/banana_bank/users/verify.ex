defmodule BananaBank.Users.Verify do
  alias BananaBank.Repo
  alias BananaBank.Users
  alias Users.User

  def call(%{"email" => email, "password" => password}) do
    case Repo.get_by(User, email: email) do
      nil -> {:error, :not_found}
      user -> verify(password, user)
    end
  end

  defp verify(password, user) do
    case Pbkdf2.verify_pass(password, user.password_hash) do
      true -> {:ok, user}
      false -> {:error, :unauthorized}
    end
  end
end
