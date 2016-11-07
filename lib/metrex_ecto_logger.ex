defmodule MetrexEctoLogger do

  def log(log_entry) do
    System.convert_time_unit(log_entry.decode_time, :native, :milliseconds) |> ExStatsD.histogram("ecto.decode.time")
    System.convert_time_unit(log_entry.query_time, :native, :milliseconds) |> ExStatsD.histogram("ecto.query.time")
    System.convert_time_unit(log_entry.queue_time, :native, :milliseconds) |> ExStatsD.histogram("ecto.queue.time")
    ExStatsD.increment("ecto.table.#{log_entry.source}")
    ExStatsD.increment("ecto.query.count")
  end
  
end