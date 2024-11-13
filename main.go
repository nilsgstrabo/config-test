package main

import (
	"log/slog"
	"net/http"
)

func main() {
	slog.Info("starting server")
	if err := http.ListenAndServe(":5000", http.HandlerFunc(handler)); err != nil {
		slog.Error(err.Error())
	}
}

func handler(w http.ResponseWriter, r *http.Request) {
	slog.Info("request")
	w.WriteHeader(200)
	w.Write([]byte("Hello universe"))
}
