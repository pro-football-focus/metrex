defmodule MetrexPlug do
  @behaviour Plug
  import Plug.Conn, only: [register_before_send: 2]

  def init(opts), do: opts

  def call(conn, _config) do
    before_time = :os.timestamp

    register_before_send conn, fn conn ->
      :timer.now_diff(:os.timestamp, before_time) / 1_000 |> ExStatsD.histogram("resp.time")
      # @TODO - increment a counter for the URI
      ExStatsD.increment("resp.count")

      conn
    end
  end

end
