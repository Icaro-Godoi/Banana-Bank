defmodule BananaBank.ViaCep.ClientTest do
  alias BananaBank.ViaCep.Client
  use ExUnit.Case, async: true

  setup do
    bypass = Bypass.open()
    {:ok, bypass: bypass}
  end

  describe "call/1" do
    test "successfully returns cep info", %{bypass: bypass} do
      cep = 18_040_432

      body =
        ~s({
          "bairro": "Jardim Embaixador",
          "cep": "18040-432",
          "complemento": "",
          "ddd": "15",
          "gia": "6695",
          "ibge": "3552205",
          "localidade": "Sorocaba",
          "logradouro": "Rua dos Contabilistas",
          "siafi": "7145",
          "uf": "SP",
          "unidade": ""
        })

      Bypass.expect(bypass, "GET", "/#{cep}/json", fn conn ->
        conn
        |> Plug.Conn.put_resp_content_type("application/json")
        |> Plug.Conn.resp(200, body)
      end)

      expected_response =
        {:ok,
         %{
           "bairro" => "Jardim Embaixador",
           "cep" => "18040-432",
           "complemento" => "",
           "ddd" => "15",
           "gia" => "6695",
           "ibge" => "3552205",
           "localidade" => "Sorocaba",
           "logradouro" => "Rua dos Contabilistas",
           "siafi" => "7145",
           "uf" => "SP",
           "unidade" => ""
         }}

      response =
        bypass.port
        |> endpoint_url()
        |> Client.call(cep)

      assert response == expected_response
    end
  end

  defp endpoint_url(port), do: "http://localhost:#{port}/"
end
