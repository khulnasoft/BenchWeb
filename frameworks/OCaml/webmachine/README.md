# webmachine Benchmarking Test

### Test Type Implementation Source Code

* [JSON](src/bw.ml#L49-L69)
* [PLAINTEXT](src/bw.ml#L49-L69)
* [DB](src/bw.ml#L71-L100)
* [QUERY](src/bw.ml#L102-L151)

## Important Libraries
* [Webmachine](https://github.com/inhabitedtype/ocaml-webmachine)
* [Cohttp](https://github.com/mirage/ocaml-cohttp/issues/328)
* [Caqti](https://github.com/paurkedal/ocaml-caqti)
* [Lwt](https://github.com/ocsigen/lwt)
* [Ezjsonm](https://github.com/mirage/ezjsonm)
* [Ptime](https://github.com/dbuenzli/ptime)

## Test URLs
### JSON

http://localhost:8080/json

### PLAINTEXT

http://localhost:8080/plaintext

### DB

http://localhost:8080/db

### QUERY

http://localhost:8080/queries/
