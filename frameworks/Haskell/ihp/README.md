# IHP Benchmarking Test

This is the IHP implementation of a [benchmarking test suite](../) comparing a variety of web development platforms.

### Test Type Implementation Source Code

* [JSON](src/Web/Controller/BenchWeb.hs#15)
* [DB](src/Web/Controller/BenchWeb.hs#18)
* [QUERY](src/Web/Controller/BenchWeb.hs#23)
* [FORTUNES](src/Web/Controller/BenchWeb.hs#32)
* [UPDATE](src/Web/Controller/BenchWeb.hs#39)
* [PLAINTEXT](src/Web/Controller/BenchWeb.hs#52)

## Test URLs
### JSON

http://localhost:8080/json

### PLAINTEXT

http://localhost:8080/plaintext

### DB

http://localhost:8080/db

### QUERY

http://localhost:8080/query?queries=


### UPDATE

http://localhost:8080/update?queries=

### FORTUNES

http://localhost:8080/fortunes