defmodule MetrexEctoLogger do

  def log(log_entry) do
    System.convert_time_unit(log_entry.query_time, :native, :microseconds) / 1000 |> ExStatsD.histogram("ecto.query.time")
    ExStatsD.increment("ecto.query.count")
  end
  
end