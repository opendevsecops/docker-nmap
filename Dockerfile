FROM ubuntu:latest

ENV DEBIAN_FRONTEND noninteractive

RUN true \
    && apt-get update \
    && apt-get install -y \
        curl \
        git \
        build-essential \
        libpcap-dev \
    && apt-get clean

WORKDIR /

RUN git clone https://github.com/nmap/nmap

WORKDIR /nmap

RUN ./configure
RUN make -j
RUN make install
RUN chmod +s /usr/local/bin/nmap
RUN chmod +s /usr/local/bin/nping

ENTRYPOINT ["/usr/local/bin/nmap"]
