# General release info
APP_NAME				= httpdump-alpine
DOCKER_ACCOUNT	= boeboe
VERSION					= 1.0.0

# HELP
# This will output the help for each task
# thanks to https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
.PHONY: help

help: ## This help
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z0-9_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.DEFAULT_GOAL := help


#### DOCKER TASKS ###

build: ## Build the container
	docker build ${DOCKER_BUILD_ARGS} -t $(DOCKER_ACCOUNT)/$(APP_NAME) --build-arg VERSION=${VERSION} .

build-nc: ## Build the container without caching
	docker build ${DOCKER_BUILD_ARGS} --no-cache -t $(DOCKER_ACCOUNT)/$(APP_NAME) --build-arg VERSION=${VERSION} .

run: ## Run container
	docker run --name="$(APP_NAME)" $(DOCKER_ACCOUNT)/$(APP_NAME)

up: build run ## Build and run container on port configured

stop: ## Stop and remove a running container
	docker stop $(APP_NAME) || true
	docker rm $(APP_NAME) || true

release: build-nc publish ## Make a full release

publish: ## Tag and publish container
	@echo 'create tag $(DOCKER_TAG)'
	docker tag $(DOCKER_ACCOUNT)/$(APP_NAME) $(DOCKER_ACCOUNT)/$(APP_NAME):$(DOCKER_TAG)
	@echo 'publish $(VERSION) to $(DOCKER_ACCOUNT)/$(APP_NAME):$(DOCKER_TAG)'
	docker push $(DOCKER_ACCOUNT)/$(APP_NAME):$(DOCKER_TAG)
