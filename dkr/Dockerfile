FROM ubuntu:16.04 as ppy-builder
MAINTAINER blckchnd

RUN \
        apt-get update && \
        apt-get install -y \
          build-essential \
          autotools-dev \
          automake \
          autoconf \
          libtool \
          make \
          cmake \
          git \
          libreadline-dev \
          libssl-dev \
          libboost-all-dev \
          libcurl4-openssl-dev \
          python-dev \
          doxygen \
          wget \
        && \
        apt-get clean && \
        rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ARG BRANCH_NAME=1.1.0
ARG COMMIT=320782b61e7ebe49a06f8703ccb409f37efc1958

RUN \
    git clone https://github.com/peerplays-network/peerplays /source  && \
    cd /source && git checkout ${BRANCH_NAME} && \
    git submodule update --init --recursive

WORKDIR /source

RUN \
    mkdir build && cd build && \
    cmake \
        -DCMAKE_BUILD_TYPE=Release \
        .. \
     && \
     make -j4 && \
     make install && \
     git rev-parse --short HEAD > /version && \
     cd / && \
     rm -rf /tmp/* /source

FROM ubuntu:16.04

WORKDIR /var/lib/peerplays
ENV HOME /var/lib/peerplays

RUN mkdir /usr/share/peerplays
ADD config.ini.example /usr/share/peerplays/config.ini.example

COPY --from=ppy-builder /usr/local/bin/witness_node /usr/local/bin/witness_node
COPY --from=ppy-builder /usr/local/bin/cli_wallet /usr/local/bin/cli_wallet
COPY --from=ppy-builder /version /usr/share/peerplays/version

# default exec/config files
ADD peerplaysentry.sh /usr/local/bin/peerplaysentry.sh
RUN chmod a+x /usr/local/bin/peerplaysentry.sh

# Volume
VOLUME "/var/lib/peerplays"

# rpc service:
EXPOSE 8090
# p2p service:
EXPOSE 2001

# default execute entry
CMD /usr/local/bin/peerplaysentry.sh
