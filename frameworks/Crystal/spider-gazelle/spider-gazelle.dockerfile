FROM 84codes/crystal:1.7.2-alpine
RUN apk add --update --no-cache bash gmp-dev

WORKDIR /usr/src/app

COPY shard.yml ./
COPY src src
COPY run.sh run.sh

# Build App
RUN shards build --release --no-debug

ENV DATABASE_URL postgres://benchmarkdbuser:benchmarkdbpass@bw-database:5432/hello_world?initial_pool_size=56&max_idle_pool_size=56

ENV SG_ENV production

# Run the app binding on port 8080
EXPOSE 8080
ENTRYPOINT []

CMD bash run.sh
