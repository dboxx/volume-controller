IMAGE = dboxx/volume-controller
TAG = v0.1

# Colors
COLNO=\033[0m
COLERR=\033[31;01m
COLWARN=\033[33;01m
COLMENU=\033[36m

.PHONY: help pull push run build latest

help:   ## show list
	@echo "Git: https://github.com/$(IMAGE)"
	@echo "Hub: https://hub.docker.com/r/$(IMAGE)"
	@echo " > docker pull $(IMAGE)"
	@echo " > docker run --name volume-controller --privileged --rm -v /tmp:/tmp:rw -it $(IMAGE) bash"
	@echo "-----"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "$(COLMENU)%-10s$(COLNO) %s\n", $$1, $$2}'

pull:   ## pull image
	@docker pull $(IMAGE):$(TAG)

push:   ## push image
	@docker push $(IMAGE):$(TAG)

run:    ## run image
	@docker run --name volume-controller --privileged --rm -v /tmp:/tmp:rw -it $(IMAGE):$(TAG) bash

build:  ## build new image
	@docker build . -t $(IMAGE):$(TAG)

latest: ## mark image as latest
	@docker tag $(IMAGE):$(TAG) $(IMAGE):latest
	@docker push $(IMAGE):latest
