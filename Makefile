SHELL := /bin/bash
.PHONY: clean compile setup test 
all: test
setup:
	mix do deps.get, deps.clean --unused
test:
	MIX_ENV=test mix do clean + compile --warnings-as-errors + coveralls.html --warnings-as-errors
