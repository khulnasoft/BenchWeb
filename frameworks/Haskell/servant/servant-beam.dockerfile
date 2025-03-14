FROM haskell:8.6.5

RUN apt-get update -yqq && apt-get install -yqq xz-utils make
RUN apt-get install -yqq libpq-dev

WORKDIR /app

# Update cabal here
RUN cabal update

# First add only
COPY cabal.project ./
COPY ./servant-bw/servant-bw.cabal ./servant-bw/servant-bw.cabal
RUN find .
RUN cabal v2-build warp
RUN cabal v2-build wai-app-static
RUN cabal v2-build beam-postgres
RUN cabal v2-build servant-server

ADD ./servant-bw ./servant-bw
RUN cabal v2-build all

RUN cp $(find dist-newstyle -name servant-bw-beam -type f) /app/dist-newstyle/servant-bw-beam

EXPOSE 7041

CMD /app/dist-newstyle/servant-bw-beam +RTS -A32m -N$(nproc) -qn2 -M2G -RTS
