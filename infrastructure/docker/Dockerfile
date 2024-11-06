FROM ubuntu:24.04

ARG DEBIAN_FRONTEND=noninteractive
# WARNING: DON'T PUT A SPACE AFTER ANY BACKSLASH OR APT WILL BREAK
RUN apt-get -yqq update && \
    apt-get -yqq install \
      -o Dpkg::Options::="--force-confdef" \
      -o Dpkg::Options::="--force-confold" \
      cloc \
      curl \
      gcc \
      git-core \
      gosu \
      libmysqlclient-dev \
      libpq-dev \
      pkg-config \
      python3 \
      python3-colorama \
      python3-dev \
      python3-dnspython \
      python3-packaging \
      python3-pip \
      python3-psutil \
      python3-psycopg2 \
      python3-requests \
      siege \
      software-properties-common && \
    pip3 install \
      --break-system-packages \
      docker==7.0.0 \
      mysqlclient==2.2.4 \
      pymongo==4.7.2

# Collect resource usage statistics
ARG DOOL_VERSION=v1.3.1

WORKDIR /tmp
RUN curl -LSs "https://github.com/scottchiefbaker/dool/archive/${DOOL_VERSION}.tar.gz" -o dool.tar.gz && \
    echo "ACTUAL_CHECKSUM  dool.tar.gz" | sha256sum -c - && \
    tar --strip-components=1 -xz -f dool.tar.gz && \
    ./install.py

ARG GROUP_ID=1000
RUN if ! getent group "$GROUP_ID"; then \
      addgroup --gid "$GROUP_ID" user; \
    fi

ARG USER_ID=1000
RUN if ! getent passwd "$USER_ID"; then \
      adduser --disabled-password --gecos '' --gid "$GROUP_ID" --uid "$USER_ID" user; \
    fi

ENV FWROOT=/BenchWeb USER_ID="$USER_ID"
ENV PYTHONPATH="$FWROOT"

ENTRYPOINT ["/BenchWeb/infrastructure/docker/entrypoint.sh"]
