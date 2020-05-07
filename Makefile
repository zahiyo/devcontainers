##
# Helper to run common docker commands.
#
# Usage:
#	make [TARGET] [ARGS...]
#
# Example:
#
# - To build the base ubuntu container
#	make build TYPE=base TAG=ubuntu
# or, since the default values for TYPE and TAG are 'base' and 'ubuntu'
#	make build
#
# - To run base alpine development container and configure a Git user
#	make run TYPE=base TAG=alpine OPTIONS="-e GIT_USER_NAME='Your Name' -e GIT_USER_EMAIL='youremail@yourdomain.com'"

.PHONY: build help run

# Default TAG to ubuntu if not set
ifndef TAG
override TAG = ubuntu
endif

# Default TYPE to base if not set
ifndef TYPE
override TYPE = base
endif

help: ## Show this help
	@echo
	@echo 'Usage: make TARGET [ARGS=...]'
	@echo
	@echo Execute a docker command
	@echo
	@echo 'Targets:'
	@egrep '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\t%-20s %s\n", $$1, $$2}'
	@echo 'Args:'
	@printf "\t%-20s %s\n" 'TYPE' "Type of container (default value: 'base'). Possible values: [base, node, serverless]"
	@printf "\t%-20s %s\n" 'TAG' "Version of the container (default value: 'ubuntu'). Possible values: [alpine, ubuntu]"
	@printf "\t%-20s %s\n" 'OPTIONS' "Any docker options for the executed command"

build: ## Build and tag a development container
	docker build $(OPTIONS) -t zahiyo/devcontainer-$(TYPE):$(TAG) -f containers/$(TYPE)/Dockerfile-${TAG} ./containers/$(TYPE)

run: ## Run a new development container and connect to it
	docker run -it --rm $(OPTIONS) zahiyo/devcontainer-${TYPE}:$(TAG)
