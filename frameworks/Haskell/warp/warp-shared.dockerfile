FROM haskell:8.6.3

RUN apt-get update -yqq && apt-get install -yqq xz-utils make
RUN apt-get install -yqq libpq-dev

WORKDIR /app

COPY stack.yaml ./
COPY ./shared/bw-types/bw-types.cabal ./shared/bw-types/
COPY ./shared/bw-hasql/bw-hasql.cabal ./shared/bw-hasql/
COPY ./shared/bw-mysql-haskell/bw-mysql-haskell.cabal ./shared/bw-mysql-haskell/
COPY ./shared/bw-postgres-wire/bw-postgres-wire.cabal ./shared/bw-postgres-wire/
COPY ./warp-shared/warp-shared.cabal ./warp-shared/
RUN stack setup
RUN stack install --dependencies-only

ADD ./shared ./shared
ADD ./warp-shared ./warp-shared
RUN stack build --pedantic --copy-bins
RUN ln -s ~/.local/bin/warp-postgres-wire ~/.local/bin/warp

ARG BW_TEST_NAME
ENV BW_TEST_NAME=${BW_TEST_NAME}

EXPOSE 7041

CMD stack exec $BW_TEST_NAME -- bw-database +RTS -A32m -N$(nproc)
