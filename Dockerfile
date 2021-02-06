FROM golang:1.14-alpine AS build
WORKDIR /go/src/app
ENV CGO_ENABLED=0

COPY go.mod go.sum ./
RUN go mod graph | awk '$1 !~ /@/ { print $2 }' | xargs -r go get

COPY main.go ./
RUN go build -o /go/bin/app

FROM scratch
COPY --from=build /go/bin/app /
ENTRYPOINT ["/app"]