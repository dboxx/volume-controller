package main

import (
	"log"

	"github.com/dboxx/volume-controller/pkg/controller"
)

func main() {
	c := controller.New(controller.Config{
		Addr: ":80",
	})

	log.Fatal(c.Run())
}
