# Golang Docker Dependency Cache

If you've switched to go modules you might have found your docker builds have slowed down due `go build` needing to recompile all the dependencies even if they have already been downloaded or vendored.

There is an [open issue](https://github.com/golang/go/issues/27719) but until it's built into the `go` cli this will cause your builds to be much faster.

## Usage

```
COPY go.mod go.sum ./

# Add this line before `go build`
RUN go mod graph | grep -v '@.*@' | awk '{print $2}' | xargs go get
```

Full Dockerfile example: [./Dockerfile](./Dockerfile)

## Benchmarks

With `go mod graph | grep -v '@.*@' | awk '{print $2}' | xargs go get` dependency cache:

```
# First run:
13.54 real         0.12 user         0.07 sys

# Change main.go whitespace:
2.74 real         0.12 user         0.10 sys
```

With `go mod download` dependency cache:

```
# First run:
15.13 real         0.13 user         0.09 sys

# Change main.go whitespace:
9.03 real         0.12 user         0.10 sys
```

Without any dependency cache:

```
# First run:
12.12 real         0.12 user         0.08 sys

# Change main.go whitespace:
12.19 real         0.12 user         0.10 sys
```