.PHONY: all install-deps lint unit-test integration-test test fmt help

all: install-deps lint test

install-deps:
	go get -t github.com/basho/riak-go-client/...

lint: install-deps
	go tool vet -shadow=true -shadowstrict=true $(PROJDIR)
	go vet github.com/basho/riak-go-client/...

unit-test: lint
	go test -v

# runs unit tests as well
integration-test: lint
	go test -v -tags=integration

integration-test-hll: lint
	go test -v -tags=integration_hll

timeseries-test: lint
	go test -v -tags=timeseries

test: integration-test

fmt:
	gofmt -s -w .

protogen:
	$(PROJDIR)/build/protogen $(PROJDIR)

help:
	@echo ''
	@echo ' Targets:'
	@echo '----------------------------------------------------------'
	@echo ' all                  - Run everything                    '
	@echo ' fmt                  - Format code                       '
	@echo ' lint                 - Run "go vet"                      '
	@echo ' test                 - Run unit & integration tests      '
	@echo ' unit-test            - Run unit tests                    '
	@echo ' integration-test     - Run integration tests             '
	@echo ' integration-test-hll - Run Hyperloglog integration tests '
	@echo ' timeseries-test      - Run timeseries integration tests  '
	@echo '----------------------------------------------------------'
	@echo ''
