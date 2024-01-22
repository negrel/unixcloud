repository_root := $(shell git rev-parse --show-toplevel)
repository_root := $(or $(repository_root), $(CURDIR))
include $(repository_root)/variables.mk

.PHONY: start
start:
	$(DOCKER_COMPOSE) $(UNIXCLOUD_COMPONENTS_DOCKER_COMPOSE_FILES_FLAGS) up --wait

.PHONY: stop
stop:
	$(DOCKER_COMPOSE) $(UNIXCLOUD_COMPONENTS_DOCKER_COMPOSE_FILES_FLAGS) stop

.PHONY: down
down: clean

.PHONY: clean
clean:
	$(DOCKER_COMPOSE) $(UNIXCLOUD_COMPONENTS_DOCKER_COMPOSE_FILES_FLAGS) down --volumes --remove-orphans
