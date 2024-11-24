# [Just-JS](https://github.com/just-js) Benchmarking Test

This test benchmarks the [Just-JS](https://github.com/just-js) framework.

Author: Andrew Johnston <billy@billywhizz.io>

## Test Type Implementation Source Code

* [JSON] khulnasoft.js
* [PLAINTEXT] khulnasoft.js
* [DB] khulnasoft.js
* [QUERY] khulnasoft.js
* [CACHED QUERY] khulnasoft.js
* [UPDATE] khulnasoft.js
* [FORTUNES] khulnasoft.js

## Test URLs

### JSON

http://localhost:8080/json

### PLAINTEXT

http://localhost:8080/plaintext

### DB

http://localhost:8080/db

### QUERY

http://localhost:8080/query?q=

### UPDATE

http://localhost:8080/update?q=

### FORTUNES

http://localhost:8080/fortunes

### CACHED QUERY

http://localhost:8080/cached-world?q=

## Building the Docker Image
```bash
docker build -t khulnasoft:latest -f just.dockerfile .
```

## Running the BW Postgres Docker Container
```bash
## docker network create -d bridge bw
docker run -p 5432:5432 -d --rm --name bw-database --network bw khulnasoft/bw.database.postgres:latest
```

## Running the Docker Container
```bash
docker run -p 8080:8080 -d --rm --name bw-server --network bw khulnasoft:latest
```