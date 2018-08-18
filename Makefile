.PHONY: build test

DOCKER_COMPOSE  ?= docker-compose
DOCKER_HOST_IP ?= 127.0.0.1
OPEN_CMD ?= open
GROUP ?= all

all:	 ##@test [TEST] shorthand for
	$(MAKE) up run-tests

up:      ##@development start stack
	$(DOCKER_COMPOSE) up -d chrome firefox

clean:   ##@development remove all containers in stack
	$(DOCKER_COMPOSE) kill
	$(DOCKER_COMPOSE) rm -fv --all
	$(DOCKER_COMPOSE) down --rmi local --remove-orphans

bash:	 ##@development open application development bash
	$(DOCKER_COMPOSE) run --rm --entrypoint bash codecept

run-tests:	 ##@test run tests
	$(DOCKER_COMPOSE) run codecept run -x optional -vv --html=_report.html --env firefox --env chrome --env phpbrowser -g ${GROUP}

clean-tests:	 ##@test run tests
	$(DOCKER_COMPOSE) run codecept clean -vv

open-vnc:	 ##@test open application database service in browser
	$(OPEN_CMD) vnc://x:secret@$(DOCKER_HOST_IP):$(shell $(DOCKER_COMPOSE) port chrome 5900 | sed 's/[0-9.]*://')
	$(OPEN_CMD) vnc://x:secret@$(DOCKER_HOST_IP):$(shell $(DOCKER_COMPOSE) port firefox 5900 | sed 's/[0-9.]*://')
