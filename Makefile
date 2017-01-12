NAME = invo
VERSION = 1.0
CUR_DIR = $(shell basename $(CURDIR))

.PHONY: start dev_up composer bower dbmigrate

build_up:
	docker-compose up -d --build --remove-orphans

dev_up:
	docker-compose up -d --remove-orphans

ps:
	docker-compose ps

ssh:
	docker exec -it prjtopdev_${NAME}_${SERVICE}_1 /bin/bash

logs:
	docker-compose logs -f

logs_service:
	docker-compose logs -f ${NAME}_${SERVICE}

dbmigrate-generate:
	docker-compose exec invo_adminer doctrine-migrations migrations:generate

dbmigrate:
	docker-compose exec invo_adminer doctrine-migrations migrations:migrate -n

dbmigrate-down:
	docker-compose exec invo_adminer doctrine-migrations migrations:migrate prev -n
