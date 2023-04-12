.PHONY: all
all: up

.PHONY: up
up:
	docker compose -f ./srcs/docker-compose.yml up --build -d

.PHONY: down
down:
	docker compose -f ./srcs/docker-compose.yml down

.PHONY: clean
clean:
	docker compose -f ./srcs/docker-compose.yml down -v

.PHONY: re
re: clean up
