defmodule Metrex.Plug do
  @behaviour Plug
  import Plug.Conn, only: [register_before_send: 2]

  def init(opts), do: opts

  def call(conn, _config) do
    path = normalize_path(conn.path_info)

    ExStatsD.increment("req.count")
    ExStatsD.increment("req.#{conn.method}.#{path}")
    before_time = :os.timestamp
    register_before_send conn, fn conn ->
      :timer.now_diff(:os.timestamp, before_time) / 1_000
      |> ExStatsD.histogram("resp.time")
      conn
    end
  end

  @doc """
  Normalize Plug.Conn.path_info so that path parameters are excluded

  ## Examples

  iex> Metrex.Plug.normalize_path(["api", "franchise"])
  "api.franchise"

  iex> Metrex.Plug.normalize_path(["api", "franchise", "12"])
  "api.franchise"
  """
  def normalize_path(path_info) do
    Enum.reject(path_info, fn(x) -> Regex.match?(~r/^[0-9]+$/, x) end) |> Enum.join(".")
  end

end
