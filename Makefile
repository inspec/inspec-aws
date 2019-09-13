
build_test:
	docker-compose run --rm builder 


rebuild:
	docker-compose build --force-rm --no-cache