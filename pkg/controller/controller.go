package controller

import (
	"net/http"
)

type Controller interface {
	Run() error
}

func New(c Config) Controller {
	return &controller{
		config: c,
	}
}

type controller struct {
	config Config
}

func (c *controller) Run() error {
	http.HandleFunc("/v1/status", c.statusHandler)
	return http.ListenAndServe(c.config.Addr, nil)
}
