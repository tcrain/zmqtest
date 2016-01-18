REBAR = $(shell pwd)/rebar
.PHONY: rel deps test

all: deps compile

compile: deps
	$(REBAR) compile

deps:
	$(REBAR) get-deps

clean:
	$(REBAR) clean

rel: all
	$(REBAR) generate

relclean:
	rm -rf rel/zmqtest
