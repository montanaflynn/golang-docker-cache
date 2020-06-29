package main

import (
	"log"

	badger "github.com/dgraph-io/badger/v2"
)

func main() {
	db, err := badger.Open(badger.DefaultOptions("").WithInMemory(true))
	if err != nil {
		log.Fatal(err)
	}
	defer db.Close()
}
