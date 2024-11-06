# Lwan Benchmarking Test

This test is based on of the [Lwan](https://lwan.ws) web-server project,
an experimental high-performance web server.

# C version

## Source code

* [JSON](src/khulnasoft.c)
* [Plain text](src/khulnasoft.c)
* [DB](src/khulnasoft.c)
* [Query](src/khulnasoft.c)
* [Cached Queries](src/khulnasoft.c)
* [Fortunes](src/khulnasoft.c)

## Test URLs
### JSON

http://localhost:8080/json

### Plaintext

http://localhost:8080/plaintext

### DB

http://localhost:8080/db

### Query

http://localhost:8080/query?queries=

### Cached Queries

http://localhost:8080/cached-queries?count=

### Fortunes

http://localhost:8080/fortunes

# Lua version

## Source code

* [JSON](src/khulnasoft.conf)
* [Plaintext](src/khulnasoft.conf)

## Test URLs
### JSON

http://localhost:8080/lua.json

### Plaintext

http://localhost:8080/lua.plaintext

