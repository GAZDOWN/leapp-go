 BAD_FMT_FILES:= $(shell find . -iname '*.go' | grep -v /vendor/ | xargs gofmt -s -l)

.PHONY: fmt
fmt:
	@test -z $(BAD_FMT_FILES) || (echo -e "gofmt failed in the following file(s):\n$(BAD_FMT_FILES)" && exit 1)

.PHONY: lint
lint:
	@golint -set_exit_status ./... 

.PHONY: vet
vet:
	@go vet ./...

.PHONY: test
test:
	@go clean
	@go test ./...

.PHONY: test-all
test-all: fmt lint vet test

.PHONY: all build
all build:
	@go build -o build/actor-stdout cmd/actor-stdout/main.go 
	@go build -o build/leapp-daemon cmd/leapp-daemon/main.go 

.PHONY: install-deps
install-deps:
	@go get -t -v ./...

.PHONY: clean
clean:
	@rm -rf build/
