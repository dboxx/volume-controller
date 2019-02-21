package controller

import (
	"net/http"
)

const (
	HeaderContentType   = "Content-Type"
	HeaderContentLength = "Content-Length"
	ContentTypeJSON     = "application/json"
)

func (c *controller) statusHandler(w http.ResponseWriter, r *http.Request) {
	w.Header().Set(HeaderContentType, ContentTypeJSON)
	w.WriteHeader(http.StatusOK)
	w.Write([]byte(`{"status":"ok"}`))
}
