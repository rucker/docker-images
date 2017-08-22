include ../../scripts/Makefile

NAME=ubuntu-dev

# DEFAULT: ARGS=--build-arg user=$(USER)
#         BUILD $(ARGS)
build:
	docker build . --tag=$(GROUP)/$(NAME):$(VERSION) --build-arg user=$(USER)
