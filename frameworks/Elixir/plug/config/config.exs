import Config

config :framework_benchmarks, ecto_repos: [BenchWeb.Repo]

import_config "#{Mix.env()}.exs"
