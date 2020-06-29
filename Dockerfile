FROM golang:1.14-alpine AS build
WORKDIR /go/src/app
ENV CGO_ENABLED=0
RUN apk add --no-cache jq
COPY go.mod go.sum ./
RUN go mod download --json | jq -r '"\(.Path)@\(.Version)"' | xargs go get -v
COPY . .
RUN go build -o /go/bin/app

FROM gcr.io/distroless/base
COPY --from=build /go/bin/app /
ENTRYPOINT ["/app"]