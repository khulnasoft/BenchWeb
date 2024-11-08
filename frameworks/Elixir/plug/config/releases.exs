import Config

config :logger,
  compile_time_purge_matching: [
    [level_lower_than: :error]
  ],
  level: :error,
  backends: []

config :framework_benchmarks, BenchWeb.Repo,
  username: "benchmarkdbuser",
  password: "benchmarkdbpass",
  database: "hello_world",
  hostname: "bw-database",
  port: 5432,
  pool_size: 40,
  queue_target: 5000,
  log: false
