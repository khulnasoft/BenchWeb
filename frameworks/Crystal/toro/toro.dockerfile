FROM crystallang/crystal:1.12.1

WORKDIR /toro
COPY views views
COPY run.sh run.sh
COPY toro.cr toro.cr
COPY shard.yml shard.yml

ENV DATABASE_URL postgres://benchmarkdbuser:benchmarkdbpass@bw-database:5432/hello_world

RUN shards install
RUN crystal build  --release --no-debug toro.cr

EXPOSE 8080

CMD bash run.sh
