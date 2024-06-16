PHONY: help build start
.DEFAULT_GOAL:= help

IMAGE_NAME := open_sora_plan:dev
CURRENT_UID := $(shell id -u)


help:  ## describe make commands
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

build:  ## build image
	@DOCKER_BUILDKIT=1 docker build --ssh default=$$SSH_AUTH_SOCK --build-arg USERNAME=$(USER) --build-arg USER_UID=$(CURRENT_UID) -t $(IMAGE_NAME) docker

start:  ## start containerized Jupyter Lab + MLFlow # mlflow
	./docker/docker_run.sh

stop: ## Stop the Docker container with the specified tag
	@echo "Stopping Docker container with tag $(IMAGE_NAME)"
	@docker stop $(shell docker ps -q --filter "ancestor=$(IMAGE_NAME)")