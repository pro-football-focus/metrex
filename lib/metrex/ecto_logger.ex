defmodule Metrex.EctoLogger do

  def log(%{query_time: query_time}) do
    query_time
    |> native_to_milliseconds()
    |> ExStatsD.histogram("ecto.query.time")

    ExStatsD.increment("ecto.query.count")
  end

  @doc """
  Converts native time to milliseond representation

  ## Examples

  iex> Metrex.EctoLogger.native_to_milliseconds(nil)
  0
  iex> Metrex.EctoLogger.native_to_milliseconds(100000000)
  100.0
  iex> Metrex.EctoLogger.native_to_milliseconds(100000)
  0.1
  """
  def native_to_milliseconds(nil), do: 0
  def native_to_milliseconds(time) do
    System.convert_time_unit(time, :native, :microseconds) / 1000
  end

end
