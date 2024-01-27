repository_root := $(shell git rev-parse --show-toplevel)
repository_root := $(or $(repository_root), $(CURDIR))
include $(repository_root)/variables.mk

.PHONY: start
start: setup
	$(DOCKER_COMPOSE) $(UNIXCLOUD_COMPONENTS_DOCKER_COMPOSE_FILES_FLAGS) up --wait

restart/%:
	$(DOCKER_COMPOSE) $(UNIXCLOUD_COMPONENTS_DOCKER_COMPOSE_FILES_FLAGS) restart $*

.PHONY: stop
stop:
	$(DOCKER_COMPOSE) $(UNIXCLOUD_COMPONENTS_DOCKER_COMPOSE_FILES_FLAGS) stop

.PHONY: down
down: clean

.PHONY: clean
clean:
	$(DOCKER_COMPOSE) $(UNIXCLOUD_COMPONENTS_DOCKER_COMPOSE_FILES_FLAGS) down --volumes --remove-orphans

.PHONY: setup
setup: setup/filestructure setup/envfile

.PHONY: setup/envfile
setup/envfile:
	printenv | grep -E '^UNIXCLOUD_' > .env

.PHONY: setup/filestructure
setup/filestructure: $(UNIXCLOUD_ROOT_DIR) $(UNIXCLOUD_UPLOAD_DIR) $(UNIXCLOUD_DOWNLOAD_DIR)

$(UNIXCLOUD_ROOT_DIR):
	mkdir -p "$@"

$(UNIXCLOUD_UPLOAD_DIR):
	mkdir -p "$@"

$(UNIXCLOUD_DOWNLOAD_DIR):
	mkdir -p "$@"

exec/%: setup
	$*

.PHONY: docker/build/mediaproc
docker/build/mediaproc:
	nix build .#mediaproc-docker
	$(DOCKER) load < result
	if [ "$${REMOVE_RESULT:=1}" = "1" ]; then rm -f result; fi

.PHONY: tests
tests: test

test:
	$(MAKE) -C tests
