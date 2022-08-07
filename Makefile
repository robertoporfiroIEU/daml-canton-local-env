# USAGE
define USAGE
Usage: make [help | up | down | clear]
endef
export USAGE

UNAME := $(shell uname -s)
.PHONY:
help:
	@echo "$$USAGE"

up:
	docker-compose -f docker-compose.yml up -d $(c)

down:
	docker-compose -f docker-compose.yml down --remove-orphans $(c)



