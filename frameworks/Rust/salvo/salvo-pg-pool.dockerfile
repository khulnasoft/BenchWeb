FROM rust:1.78-buster

ENV KHULNASOFT_POSTGRES_URL=postgres://benchmarkdbuser:benchmarkdbpass@bw-database/hello_world
ENV KHULNASOFT_MAX_POOL_SIZE=28

ADD ./ /salvo
WORKDIR /salvo

ENV RUSTFLAGS "-C target-cpu=native"
RUN cargo build --release

EXPOSE 8080

CMD ./target/release/main-pg-pool
