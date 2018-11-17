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

RUN true \
  && ./configure \
  && make -j \
  && make install \
  && chmod +s /usr/local/bin/nmap \
  && chmod +s /usr/local/bin/nping

WORKDIR /

RUN rm -rf /nmap

RUN true \
  && apt-get remove -y \
    git \
    build-essential \
  && apt-get clean

RUN curl https://raw.githubusercontent.com/vulnersCom/nmap-vulners/master/vulners.nse > /usr/local/share/nmap/scripts/vulners.nse

ENTRYPOINT ["/usr/local/bin/nmap"]
