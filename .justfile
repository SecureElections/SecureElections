set windows-shell := ["powershell.exe", "-NoLogo", "-Command"]
set shell := ["bash", "-uc"]
set quiet := true

default:
    just --list

# Install all dependencies
install: ent-install node-install

# Install all node modules
node-install:
    npm install

# Install Ent code-generation module
ent-install:
    go get entgo.io/ent/cmd/ent
    
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
    go run github.com/air-verse/air@latest

# Run all tests
test:
    go test ./... -race

# Build and minify Tailwind CSS
css:
    npx @tailwindcss/cli -i tailwind.css -o public/static/main.css -m

# Build CSS and compile the application binary
build: css
    go build -o ./tmp/main ./cmd/web
