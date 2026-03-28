# Build the go application into a binary
FROM golang:alpine AS builder
RUN apk add build-base
WORKDIR /app
COPY . ./
RUN go mod tidy -diff
RUN CGO_ENABLED=1 GOOS=linux go build -o ./tmp/main ./cmd/web

# Run the binary on an empty container
FROM scratch
COPY --from=builder /app/tmp/main .
COPY --from=builder /app/config/config.yaml ./config/config.yaml
ENTRYPOINT ["/main"]
