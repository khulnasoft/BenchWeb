FROM rust:1.77
WORKDIR /trillium
COPY src src
COPY templates templates
COPY Cargo.toml Cargo.toml
COPY Cargo.lock Cargo.lock

EXPOSE 8080

ENV RUSTFLAGS="-C target-cpu=native"
ENV PORT=8080
ENV HOST=0.0.0.0
ENV DATABASE_URL=postgres://benchmarkdbuser:benchmarkdbpass@bw-database/hello_world

RUN cargo build --release --features jemallocator,smol
CMD ["./target/release/trillium-khulnasoft"]
