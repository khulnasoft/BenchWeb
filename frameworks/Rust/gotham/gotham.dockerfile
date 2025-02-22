FROM rust:1.65

WORKDIR /gotham
COPY ./src ./src
COPY ./Cargo.toml ./Cargo.toml

ENV RUSTFLAGS "-C target-cpu=native"
RUN cargo build --release

EXPOSE 8080

CMD ["./target/release/gotham_khulnasoft"]
