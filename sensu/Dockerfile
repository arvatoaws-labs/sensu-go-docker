FROM golang:1.13.15 AS builder

ARG SENSU_VERSION
ENV GOOS "linux"
ENV GOARCH "amd64"
ENV CGO_ENABLED "0"

WORKDIR /build
RUN git clone --depth=1 --single-branch --branch v${SENSU_VERSION} https://github.com/sensu/sensu-go.git

WORKDIR /build/sensu-go
RUN go mod tidy

RUN go build \
    -ldflags "-X 'github.com/sensu/sensu-go/version.Version=${SENSU_VERSION}' \
    -X 'github.com/sensu/sensu-go/version.BuildDate=$(date +%Y-%m-%d)' \
    -X 'github.com/sensu/sensu-go/version.BuildSHA=$(git rev-parse HEAD)'" \
    -o bin/sensu-agent ./cmd/sensu-agent

RUN go build \
    -ldflags "-X 'github.com/sensu/sensu-go/version.Version=${SENSU_VERSION}' \
    -X 'github.com/sensu/sensu-go/version.BuildDate=$(date +%Y-%m-%d)' \
    -X 'github.com/sensu/sensu-go/version.BuildSHA=$(git rev-parse HEAD)'" \
    -o bin/sensu-backend ./cmd/sensu-backend

RUN go build \
    -ldflags "-X 'github.com/sensu/sensu-go/version.Version=${SENSU_VERSION}' \
    -X 'github.com/sensu/sensu-go/version.BuildDate=$(date +%Y-%m-%d)' \
    -X 'github.com/sensu/sensu-go/version.BuildSHA=$(git rev-parse HEAD)'" \
    -o bin/sensuctl ./cmd/sensuctl

# FROM sensu/sensu:6.2.4 as official

FROM alpine:latest

RUN mkdir -p /opt/sensu/bin

ADD entrypoint.sh /opt/sensu/bin
COPY --from=builder /build/sensu-go/bin/sensu-agent /opt/sensu/bin/sensu-agent
# COPY --from=official /opt/sensu/bin/sensu-backend /opt/sensu/bin/sensu-backend
COPY --from=builder /build/sensu-go/bin/sensu-backend /opt/sensu/bin/sensu-backend
COPY --from=builder /build/sensu-go/bin/sensuctl /opt/sensu/bin/sensuctl

RUN apk add --no-cache ca-certificates dumb-init

RUN ln -s /opt/sensu/bin/entrypoint.sh /usr/local/bin/sensu-agent
RUN ln -s /opt/sensu/bin/entrypoint.sh /usr/local/bin/sensu-backend
RUN ln -s /opt/sensu/bin/sensuctl /usr/local/bin/sensuctl

WORKDIR /
VOLUME /var/lib/sensu
EXPOSE 2379 2380 8080 8081 3000

ENTRYPOINT ["/usr/bin/dumb-init", "--"]
CMD ["sensu-backend"]
