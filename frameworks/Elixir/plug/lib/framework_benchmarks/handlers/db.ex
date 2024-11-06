defmodule BenchWeb.Handlers.DB do
  @moduledoc """
  This is the handler for the /db route
  """
  def handle(conn) do
    id = :rand.uniform(10_000)

    json =
      BenchWeb.Repo.get(BenchWeb.Models.World, id)
      |> Jason.encode_to_iodata!()

    conn
    |> Plug.Conn.put_resp_content_type("application/json")
    |> Plug.Conn.send_resp(200, json)
  end
end
