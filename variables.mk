repository_root := $(shell git rev-parse --show-toplevel)
repository_root := $(or $(repository_root), $(CURDIR))

export DOCKER ?= docker
export DOCKER_COMPOSE ?= docker compose
export COMPOSE_PROJECT_NAME ?= unixcloud

export REPO_ROOT := $(repository_root)

export UID := $(shell id -u)
export GID := $(shell id -g)
export USERNAME := $(shell whoami)

# Domain name under which components are deployed.
export UNIXCLOUD_DOMAIN ?= unixcloud.localhost

# Root directory containing all volumes.
export UNIXCLOUD_ROOT_DIR ?= $(repository_root)/unixcloud

# Components to deploy.
export UNIXCLOUD_COMPONENTS ?= traefik httpd syncthing cron mediaproc imgproxy
export UNIXCLOUD_COMPONENTS_DOCKER_COMPOSE_FILES_FLAGS := $(UNIXCLOUD_COMPONENTS:%=-f %/docker-compose.yml)

# Root upload directory.
export UNIXCLOUD_UPLOAD_DIR ?= $(UNIXCLOUD_ROOT_DIR)/upload
export UNIXCLOUD_DOWNLOAD_DIR?= $(UNIXCLOUD_ROOT_DIR)/download
