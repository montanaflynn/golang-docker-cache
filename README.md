# Golang Docker Cache

Reproduction of a [comment in Golang issue 27719](https://github.com/golang/go/issues/27719#issuecomment-650628007).

## Usage

```
git clone git@github.com:montanaflynn/golang-docker-cache.git
cd golang-docker-cache
docker build -t golang-docker-cache .
```

## Result

```
$ docker build -t golang-docker-cache .
Sending build context to Docker daemon  47.62kB
Step 1/11 : FROM golang:1.14-alpine AS build
 ---> 3289bf11c284
Step 2/11 : WORKDIR /go/src/app
 ---> Using cache
 ---> e3b027c2ddb0
Step 3/11 : ENV CGO_ENABLED=0
 ---> Using cache
 ---> 3e3b91c43862
Step 4/11 : RUN apk add --no-cache jq
 ---> Using cache
 ---> dd27f7a8401e
Step 5/11 : COPY go.mod go.sum ./
 ---> 16622bbdd40c
Step 6/11 : RUN go mod download --json | jq -r '"\(.Path)@\(.Version)"' | xargs go get -v
 ---> Running in 32b03e99dc42
go: finding module for package github.com/ghodss/yaml
go: finding module for package github.com/prometheus/client_golang/prometheus/promhttp
go: finding module for package github.com/coreos/go-systemd/util
go: finding module for package google.golang.org/grpc
go: finding module for package google.golang.org/grpc/status
go: finding module for package github.com/soheilhy/cmux
go: finding module for package github.com/coreos/pkg/capnslog
go: finding module for package github.com/coreos/go-systemd/daemon
go: finding module for package github.com/prometheus/client_golang/prometheus
go: finding module for package github.com/grpc-ecosystem/go-grpc-prometheus
go: downloading github.com/ghodss/yaml v1.0.0
go: downloading github.com/soheilhy/cmux v0.1.4
go: downloading google.golang.org/grpc v1.30.0
go: downloading github.com/grpc-ecosystem/go-grpc-prometheus v1.2.0
go: downloading github.com/prometheus/client_golang v1.7.1
go: downloading github.com/coreos/go-systemd v0.0.0-20191104093116-d3cd4ed1dbcf
go: downloading github.com/coreos/pkg v0.0.0-20180928190104-399ea9e2e55f
go: finding module for package github.com/coreos/bbolt
go: finding module for package github.com/grpc-ecosystem/grpc-gateway/runtime
go: finding module for package google.golang.org/grpc/credentials
go: finding module for package github.com/xiang90/probing
go: finding module for package github.com/tmc/grpc-websocket-proxy/wsproxy
go: finding module for package golang.org/x/time/rate
go: finding module for package google.golang.org/grpc/health/grpc_health_v1
go: finding module for package github.com/gogo/protobuf/proto
go: downloading github.com/coreos/bbolt v1.3.5
go: downloading github.com/grpc-ecosystem/grpc-gateway v1.14.6
go: downloading github.com/xiang90/probing v0.0.0-20190116061207-43a291ad63a2
go: downloading golang.org/x/time v0.0.0-20200416051211-89c76fbcd5d1
go: downloading github.com/tmc/grpc-websocket-proxy v0.0.0-20200427203606-3cfed13b9966
go: finding module for package github.com/gogo/protobuf/gogoproto
go: finding module for package google.golang.org/grpc/metadata
go: finding module for package google.golang.org/grpc/peer
go: finding module for package google.golang.org/grpc/grpclog
go: downloading github.com/gogo/protobuf v1.3.1
go: finding module for package github.com/dgrijalva/jwt-go
go: finding module for package google.golang.org/grpc/keepalive
go: finding module for package github.com/jonboulle/clockwork
go: finding module for package github.com/golang/groupcache/lru
go: finding module for package github.com/google/btree
go: finding module for package github.com/grpc-ecosystem/grpc-gateway/utilities
go: finding module for package google.golang.org/grpc/codes
go: finding module for package google.golang.org/grpc/naming
go: finding module for package go.uber.org/zap
go: downloading github.com/dgrijalva/jwt-go v1.0.2
go: finding module for package google.golang.org/grpc/health
go: finding module for package github.com/grpc-ecosystem/go-grpc-middleware
go: downloading github.com/jonboulle/clockwork v0.1.0
go: downloading github.com/golang/groupcache v0.0.0-20200121045136-8c9f03a8e57e
go: downloading github.com/google/btree v1.0.0
go: downloading go.uber.org/zap v1.15.0
go: downloading github.com/grpc-ecosystem/go-grpc-middleware v1.2.0
go: downloading github.com/dgrijalva/jwt-go v3.2.0+incompatible
go: found github.com/coreos/go-systemd/daemon in github.com/coreos/go-systemd v0.0.0-20191104093116-d3cd4ed1dbcf
go: found github.com/coreos/pkg/capnslog in github.com/coreos/pkg v0.0.0-20180928190104-399ea9e2e55f
go: found github.com/ghodss/yaml in github.com/ghodss/yaml v1.0.0
go: found github.com/grpc-ecosystem/go-grpc-prometheus in github.com/grpc-ecosystem/go-grpc-prometheus v1.2.0
go: found github.com/soheilhy/cmux in github.com/soheilhy/cmux v0.1.4
go: found google.golang.org/grpc in google.golang.org/grpc v1.30.0
go: found github.com/jonboulle/clockwork in github.com/jonboulle/clockwork v0.1.0
go: found github.com/grpc-ecosystem/grpc-gateway/runtime in github.com/grpc-ecosystem/grpc-gateway v1.14.6
go: found github.com/tmc/grpc-websocket-proxy/wsproxy in github.com/tmc/grpc-websocket-proxy v0.0.0-20200427203606-3cfed13b9966
go: found github.com/gogo/protobuf/proto in github.com/gogo/protobuf v1.3.1
go: found github.com/prometheus/client_golang/prometheus in github.com/prometheus/client_golang v1.7.1
go: found golang.org/x/time/rate in golang.org/x/time v0.0.0-20200416051211-89c76fbcd5d1
go: found github.com/grpc-ecosystem/go-grpc-middleware in github.com/grpc-ecosystem/go-grpc-middleware v1.2.0
go: found go.uber.org/zap in go.uber.org/zap v1.15.0
go: found github.com/xiang90/probing in github.com/xiang90/probing v0.0.0-20190116061207-43a291ad63a2
go: found github.com/dgrijalva/jwt-go in github.com/dgrijalva/jwt-go v3.2.0+incompatible
go: found github.com/google/btree in github.com/google/btree v1.0.0
go: found github.com/coreos/bbolt in github.com/coreos/bbolt v1.3.5
go: found github.com/golang/groupcache/lru in github.com/golang/groupcache v0.0.0-20200121045136-8c9f03a8e57e
go: github.com/coreos/etcd imports
	github.com/coreos/etcd/etcdmain imports
	github.com/coreos/etcd/etcdserver imports
	github.com/coreos/etcd/mvcc/backend imports
	github.com/coreos/bbolt: github.com/coreos/bbolt@v1.3.5: parsing go.mod:
	module declares its path as: go.etcd.io/bbolt
	        but was required as: github.com/coreos/bbolt
The command '/bin/sh -c go mod download --json | jq -r '"\(.Path)@\(.Version)"' | xargs go get -v' returned a non-zero code: 123
```