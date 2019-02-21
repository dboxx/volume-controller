# STAGE 1. Build an application.
FROM golang:1.11.5-alpine3.8 as builder

RUN apk update \
 && apk upgrade \
 && apk add gcc make binutils libc-dev musl-dev

ENV GOPATH=/go
ENV GOROOT=/usr/local/go

ENV DIR=${GOPATH}/src/github.com/dboxx/volume-controller

WORKDIR ${DIR}

COPY pkg/ pkg/
COPY cmd/ cmd/

RUN go build -o /usr/local/sbin/volume-controller -i -v \
     -ldflags="-linkmode external -extldflags '-static'" \
     ./cmd/controller/main.go

# STAGE 2. Copy an application from stage 1.
FROM dboxx/glusterfs:5.3 as application

COPY bin/ /usr/local/sbin/
COPY --from=builder /usr/local/sbin/volume-controller /usr/local/sbin/volume-controller

