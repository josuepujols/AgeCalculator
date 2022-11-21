defmodule Birthday.Router do
  use Plug.Router

  plug(:match)
  plug(Plug.Parsers,
    parsers: [:json],
    pass: ["application/json"],
    json_decoder: Jason
  )
  plug(:dispatch)


  get "/" do
    render_json(conn, "Hello World!")
  end

  get "/age/:birthday" do
    result = Birthday.Logic.calculate_age(birthday)
    data = %{ age: result }
    render_json(conn, data)
  end

  match _ do
    send_resp(conn, 404, "Not Found")
  end

  defp render_json(%{status: status} = conn, data) do
    body = Jason.encode!(data)
    send_resp(conn, status || 200, body)
  end
end
