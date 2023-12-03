
sure: unit_test

doubly_sure: unit_test set_up int_test tear_down

unit_test:
	docker-compose run --rm --entrypoint rake tester 

int_test: 
	docker-compose run --rm --entrypoint rake tester test:run_integration_tests

set_up:
	docker-compose run --rm --entrypoint rake tester test:setup_integration_tests --trace

tear_down:
	docker-compose run --rm --entrypoint rake tester test:cleanup_integration_tests --trace

rebuild:
	docker-compose build --force-rm --no-cache

shell_aws:
	docker-compose run --rm --entrypoint bash aws

shell_tester:
	docker-compose run --rm --entrypoint bash tester

logout:
	docker-compose run --rm aws rm -rf /app/.aws
		
