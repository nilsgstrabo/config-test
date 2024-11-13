# Build stage
FROM docker.io/library/golang:1.23-alpine3.20 AS builder

WORKDIR /build

COPY go.mod go.sum ./
RUN go mod download

COPY . .

RUN CGO_ENABLED=0 go build  -installsuffix cgo -ldflags="-s -w" -o /api .

# Final stage
FROM docker.io/library/alpine:3.20

COPY --from=builder /api /usr/local/bin/api

USER 1000

ENTRYPOINT ["/usr/local/bin/api"]
