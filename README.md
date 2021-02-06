# Golang Docker Dependency Cache

If you've switched to go modules you might have found your docker builds have slowed down due `go build` needing to recompile all the dependencies even if they have already been downloaded or vendored. 

For the simple program in this repo with a single dependency I was able to get 4x improvement over doing no dependency caching and 3x compared to using `go mod download` as the dependency cache. 

There is an [open issue](https://github.com/golang/go/issues/27719) but until it's built into the `go` cli this could make your builds much faster.

## Usage

```
COPY go.mod go.sum ./

# Add this line before `go build`
RUN go mod graph | awk '$1 !~ /@/ { print $2 }' | xargs -r go get
```

Full Dockerfile example: [./Dockerfile](./Dockerfile)

## Benchmarks

I used `time` to measure how long it took to build a fresh docker image with `--no-cache` and then changed the main.go file by adding a comment so Docker would run the `go build` step again while keeping the preceeding cached docker layers. 

#### With `go mod graph | awk '$1 !~ /@/ { print $2 }' | xargs -r go get` dependency cache:

```
# Fresh build with no cache:
$ time docker build --no-cache -t golang-docker-cache .
...
13.54 real         0.12 user         0.07 sys

# Add comment to main.go:
$ time docker build -t golang-docker-cache .
2.74 real         0.12 user         0.10 sys
```

#### With `go mod download` dependency cache:

```
# Fresh build with no cache:
$ time docker build --no-cache -t golang-docker-cache .
15.13 real         0.13 user         0.09 sys

# Add comment to main.go:
$ time docker build -t golang-docker-cache .
9.03 real         0.12 user         0.10 sys
```

#### Without any dependency cache:

```
# Fresh build with no cache:
$ time docker build --no-cache -t golang-docker-cache .
12.12 real         0.12 user         0.08 sys

# Add comment to main.go:
$ time docker build -t golang-docker-cache .
12.19 real         0.12 user         0.10 sys
```
