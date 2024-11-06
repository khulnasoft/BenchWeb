fun main() {
    Http4kBenchmarkServer(PostgresDatabase()).start(BwApacheServer(9000))
}
