FROM golang:alpine AS builder


WORKDIR /tmp

RUN apk update && apk add --no-cache git go libpcap-dev upx && \
    git clone https://github.com/hsiafan/httpdump && \
    cd /tmp/httpdump && \
    GOOS=linux GOARCH=amd64 go build -ldflags '-w -extldflags "-static"'  -o /go/bin/httpdump && \
    upx /go/bin/httpdump

FROM scratch

ARG VERSION=latest

LABEL component="httpdump-scratch"
LABEL description="Golang binary httpdump in a scratch container"
LABEL version=${VERSION}
LABEL maintainer="Bart Van Bos <bartvanbos@gmail.com>"
LABEL source-repo="https://github.com/boeboe/httpdump-scratch"

WORKDIR /
COPY --from=builder /go/bin/httpdump /httpdump

ENTRYPOINT [ "/httpdump" ]
