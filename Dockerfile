FROM golang:alpine AS builder


WORKDIR /tmp

RUN apk update && apk add --no-cache git go libpcap-dev upx && \
    git clone https://github.com/hsiafan/httpdump && \
    cd /tmp/httpdump && \
    GOOS=linux GOARCH=amd64 go build -ldflags="-w -s" -o /go/bin/httpdump && \
    upx /go/bin/httpdump

FROM alpine:3.12

ARG VERSION=latest

LABEL component="httpdump-alpine"
LABEL description="Golang binary httpdump in an alpine container"
LABEL version=${VERSION}
LABEL maintainer="Bart Van Bos <bartvanbos@gmail.com>"
LABEL source-repo="https://github.com/boeboe/httpdump-alpine"

WORKDIR /
COPY --from=builder /go/bin/httpdump /usr/local/bin/httpdump
COPY --from=builder /usr/lib/libpcap.so.1 /usr/lib/libpcap.so.1

ENTRYPOINT [ "httpdump" ]
