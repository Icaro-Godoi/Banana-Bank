defmodule BananaBank.ViaCep.Client do
  alias BananaBank.ViaCep.ClientBehaviour
  use Tesla

  @default_url "https://viacep.com.br/ws"
  plug Tesla.Middleware.JSON

  @behaviour ClientBehaviour

  @impl ClientBehaviour
  def call(url \\ @default_url, cep) do
    "#{url}/#{cep}/json"
    |> get()
    |> handle_response()
  end

  defp handle_response({:ok, %Tesla.Env{status: 200, body: %{"erro" => "true"}}}), do: {:error, "Cep inválido"}
  defp handle_response({:ok, %Tesla.Env{status: 200, body: body}}), do: {:ok, body}
  defp handle_response({:ok, %Tesla.Env{status: 400}}), do: {:error, :bad_request}
  defp handle_response({:error, _}), do: {:error, :internal_server_error}
end
