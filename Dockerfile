FROM golang:alpine as build

WORKDIR /build

RUN true \
    && apk --no-cache add \
        curl

RUN true \
    && curl https://raw.githubusercontent.com/vulnersCom/nmap-vulners/master/vulners.nse > vulners.nse
  
# ---

FROM alpine:latest

WORKDIR /run

RUN true \
    && apk --no-cache add nmap

COPY --from=build /build/vulners.nse /usr/local/share/nmap/scripts/vulners.nse

ENTRYPOINT ["/usr/bin/nmap"]
