# USAGE
define USAGE
Usage: make [help | up | down | cleanup]
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

cleanup:
	./docker/clear-docker.sh $(c)

