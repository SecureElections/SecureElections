set windows-shell := ["powershell.exe", "-NoLogo", "-Command"]
set shell := ["bash", "-uc"]
set quiet := true

# Set variables by executing shell commands

os_sysname := `uname -s | tr '[:upper:]' '[:lower:]'`
os_machine := `uname -m`

# Logic to determine the specific Tailwind package string

tailwind_arch := if os_sysname == "linux" { "x64" } else { os_machine }
tailwind_package := "tailwindcss-" + os_sysname + "-" + tailwind_arch

default:
    @just --list

# Install all dependencies
install: ent-install air-install tailwind-install node-install

# Install all node modules
node-install:
    npm install

# Install the Tailwind CSS CLI
tailwind-install:
    curl -sLo tailwindcss https://github.com/tailwindlabs/tailwindcss/releases/latest/download/{{ tailwind_package }}
    chmod +x tailwindcss
    curl -sLO https://github.com/saadeghi/daisyui/releases/latest/download/daisyui.js
    curl -sLO https://github.com/saadeghi/daisyui/releases/latest/download/daisyui-theme.js

# Install Ent code-generation module
ent-install:
    go get entgo.io/ent/cmd/ent

# Install air
air-install:
    go install github.com/air-verse/air@latest

# Generate (Ent) code
gen:
    go generate ./...

# Create a new Ent entity (e.g., just ent-new MyEntity)
ent-new name:
    go run entgo.io/ent/cmd/ent new {{ name }}

format:
  go run golang.org/x/tools/cmd/goimports@latest -w `find . -name '*.go' | grep -v _gen.go$$ | grep -v .pb.go$$`
  go mod tidy 
  go fmt ./... 
  npx prettier -w .

# Create a new admin user (e.g., just admin myemail@web.com)
admin email:
    go run cmd/admin/main.go --email={{ email }}

# Run the application
run:
    clear
    go run cmd/web/main.go

# Run the application and watch for changes with air to automatically rebuild
watch:
    clear
    air

# Run all tests
test:
    go test ./...

# Build and minify Tailwind CSS
css:
    ./tailwindcss -i tailwind.css -o public/static/main.css -m

# Build CSS and compile the application binary
build: css
    go build -o ./tmp/main ./cmd/web
