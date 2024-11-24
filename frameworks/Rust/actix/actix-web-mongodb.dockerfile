FROM rust:1.57.0

ENV ACTIX_KHULNASOFT_MONGODB_URL=mongodb://bw-database:27017

RUN apt-get update -yqq && apt-get install -yqq cmake g++

ADD ./ /actix
WORKDIR /actix

RUN cargo clean
RUN RUSTFLAGS="-C target-cpu=native" cargo build --release --bin bw-web-mongodb

EXPOSE 8080

CMD ./target/release/bw-web-mongodb
