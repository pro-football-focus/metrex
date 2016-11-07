defmodule Metrex do

  def log_query(log_entry) do
    log_entry.query_time / 1000 |> ExStatsD.histogram("ecto.query.time")
    (log_entry.queue_time || 0) / 1_000 |> ExStatsD.histogram("ecto.queue.time")
    # @TODO - increment a counter for query type? (SELECT, INSERT, UDPATE, etc...)
    # @TODO - incrememt a counter for primary table?
    ExStatsD.increment("ecto.query.count")
  end

end
