## Credit to bitwalker
.PHONY: help

IMAGE_NAME ?= docker.pkg.github.com/kollegorna/asdf-docker

# alpine with asdf and all reqs installed
build_alpine: ## Rebuild the Docker image
	docker build --force-rm --file ./Dockerfile.alpine --no-cache -t $(IMAGE_NAME):alpine .

release_alpine: build_alpine ## Rebuild and release
	docker push $(IMAGE_NAME):alpine

# The builds

help:
	@echo "$(IMAGE_NAME):all"
	@perl -nle'print $& if m{^[a-zA-Z_-]+:.*?## .*$$}' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

test_rails6: ## Test the Docker image
	docker run --rm -it $(IMAGE_NAME):rails6 ruby --version

build_rails6: ## Rebuild the Docker image
	docker build --force-rm --file ./Dockerfile.rails6 --no-cache -t $(IMAGE_NAME):rails6 .

release_rails6: build_rails6 ## Rebuild and release the Docker image to Docker Hub
	docker push $(IMAGE_NAME):rails6