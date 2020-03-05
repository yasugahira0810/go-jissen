create:
	cp .envsample .env
	docker-compose up -d --build
up:
	docker-compose up -d
down:
	docker-compose down
destroy:
	docker-compose down --rmi all --volumes
exec:
	docker-compose exec app bash
build:
	docker-compose exec app go build -ldflags="-w -s" -o build/chitchat .