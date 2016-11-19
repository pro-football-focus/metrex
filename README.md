# Metrex

Elixir metric library for collection of custom application performance metrics.

## Installation

The package can be installed as:

  1. Add `metrex` to your list of dependencies in `mix.exs`:

    ```elixir
    def deps do
      [{:metrex, github: "pro-football-focus/metrex", tag: "0.1.7"}]
    end
    ```

  2. Ensure `metrex` is started before your application:

    ```elixir
    def application do
      [applications: [:metrex]]
    end
    ```

  3. Add `metrex` Ecto query hook to config/config.exs:

    ```elixir
    config :app, App.Repo,
      loggers: [
        {Ecto.LogEntry, :log, []},
        {Metrex.EctoLogger, :log, []}
      ]
    ```

  4. Add `metrex` connection plug to lib/app/endpoint.ex:

    ```elixir
    plug Metrex.Plug
    ```

  5. Configure `ex_statsd` connection in your environment file:

    ```elixir
    config :ex_statsd,
      host: "dockerhost",
      port: 8125,
      namespace: "app"
    ```
