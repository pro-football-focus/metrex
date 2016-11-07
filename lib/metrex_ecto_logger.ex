defmodule MetrexEctoLogger do

  def log(log_entry) do
    IO.inspect(log_entry)
    log_entry.query_time / 1_000_000 |> ExStatsD.histogram("ecto.query.time")
    (log_entry.queue_time || 0) / 1_000_000 |> ExStatsD.histogram("ecto.queue.time")
    # @TODO - increment a counter for query type? (SELECT, INSERT, UDPATE, etc...)
    # @TODO - incrememt a counter for primary table?
    ExStatsD.increment("ecto.query.count")
  end
  
end