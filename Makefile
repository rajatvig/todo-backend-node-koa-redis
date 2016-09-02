PACKAGE_VERSION=`node -pe "require('./package.json').version"`

OWNER=rajatvig
IMAGE_NAME=todobackendservice
QNAME=$(OWNER)/$(IMAGE_NAME)

GIT_TAG=$(QNAME):$(TRAVIS_COMMIT)
BUILD_TAG=$(QNAME):$(PACKAGE_VERSION)-$(TRAVIS_BUILD_NUMBER)
LATEST_TAG=$(QNAME):latest

.DEFAULT_GOAL := run

DC=docker-compose

login:
	@docker login -u "$(DOCKER_USER)" -p "$(DOCKER_PASS)"

stop:
	$(DC) stop

clean: stop
	$(DC) down --rmi local --remove-orphans -v
	$(DC) rm --all -f -v

run: stop
	$(DC) up --build

build_image:
	docker build -t $(GIT_TAG) .

tag_image:
	docker tag $(GIT_TAG) $(LATEST_TAG)
	docker tag $(GIT_TAG) $(BUILD_TAG)

push_image: login
	docker push $(GIT_TAG)
	docker push $(BUILD_TAG)
	docker push $(LATEST_TAG)
