defmodule BenchWeb.Handlers.CachedWorld do
  @moduledoc """
  handler for the /cached-worlds route
  """
  def handle(conn) do
    number_of_queries = BenchWeb.Handlers.Helpers.parse_queries(conn, "count")

    ids =
      1..number_of_queries
      |> Enum.map(fn _ ->
        :rand.uniform(10_000)
      end)

    json =
      ids
      |> Enum.map(&BenchWeb.CachedWorld.get/1)
      |> Jason.encode_to_iodata!()

    conn
    |> Plug.Conn.put_resp_content_type("application/json")
    |> Plug.Conn.send_resp(200, json)
  end
end
