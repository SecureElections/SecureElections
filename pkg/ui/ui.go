package ui

import (
	"fmt"
	"strconv"
	"time"
)

// cacheBuster stores the current time as a cache buster for static files.
var cacheBuster = strconv.FormatInt(time.Now().Unix(), 10)

// PublicFile generates a relative URL to a public file.
func PublicFile(filepath string) string {
	return fmt.Sprintf("/%s/%s", "files", filepath)
}

// StaticFile generates a relative URL to a static file including a cache-buster query parameter.
func StaticFile(filepath string) string {
	return fmt.Sprintf("/%s/%s?v=%s", "static", filepath, cacheBuster)
}
