MARIADB_DIR="/home/${USER}/data/mariadb"
WORDPRESS_DIR="/home/${USER}/data/wordpress"

.PHONY: all
all: up

.PHONY: up
up: volumes
	docker compose -f ./srcs/docker-compose.yml up --build -d

.PHONY: volumes
volumes:
	@mkdir -p $(MARIADB_DIR)
	@mkdir -p $(WORDPRESS_DIR)

.PHONY: down
down:
	docker compose -f ./srcs/docker-compose.yml down

.PHONY: clean
clean:
	docker compose -f ./srcs/docker-compose.yml down -v

.PHONY: re
re: clean up
