MARIADB_DIR="/home/${USER}/data/mariadb"
WORDPRESS_DIR="/home/${USER}/data/wordpress"
ADMINER_DIR="/home/${USER}/data/adminer"
ADMINER="/home/${USER}/data/adminer/index.php"

.PHONY: all
all: up

.PHONY: up
up: volumes adminer
	docker compose -f ./srcs/docker-compose.yml up --build -d

.PHONY: volumes
volumes:
	@mkdir -p $(MARIADB_DIR)
	@mkdir -p $(WORDPRESS_DIR)
	@mkdir -p $(ADMINER_DIR)

.PHONY: adminer
adminer:
	@wget -q https://www.adminer.org/latest-mysql-en.php -O $(ADMINER)


.PHONY: down
down:
	docker compose -f ./srcs/docker-compose.yml down

.PHONY: clean
clean:
	docker compose -f ./srcs/docker-compose.yml down -v

.PHONY: re
re: clean up
