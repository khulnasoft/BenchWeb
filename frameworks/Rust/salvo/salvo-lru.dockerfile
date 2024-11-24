FROM rust:1.78-buster

ENV KHULNASOFT_POSTGRES_URL=postgres://benchmarkdbuser:benchmarkdbpass@bw-database/hello_world

ADD ./ /salvo
WORKDIR /salvo

ENV RUSTFLAGS "-C target-cpu=native"
RUN cargo build --release

EXPOSE 8080

CMD ./target/release/main-lru
